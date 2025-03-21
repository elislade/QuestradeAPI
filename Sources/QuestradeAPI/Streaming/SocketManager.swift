import Foundation

#if canImport(Combine)

import Combine

public final class SocketManager {
    
    public enum Signal {
        public static let suspendAll = PassthroughSubject<Void, Never>()
        public static let resumeAll = PassthroughSubject<Void, Never>()
    }
    
    public typealias Message = URLSessionWebSocketTask.Message
    
    private let delegateWrapper: DelegateWrapper = .init()
    private let urlSession: URLSession
    private let urlRequest: URLRequest
    
    private var task: URLSessionWebSocketTask?
    private var bag: Set<AnyCancellable> = []
    
    @Published public private(set) var lastError: Error?
    public private(set) lazy var errorPublisher: AnyPublisher<Error, Never> = $lastError
        .compactMap{ $0 }
        .eraseToAnyPublisher()
    
    @Published public private(set) var isConnected = false
    public private(set) lazy var isConnectedPublisher: AnyPublisher<Bool, Never> = $isConnected
        .dropFirst()
        .removeDuplicates()
        .eraseToAnyPublisher()
    
    @Published public private(set) var lastMessage: Message?
    public private(set) lazy var messagesPublisher: AnyPublisher<Message, Never> = $lastMessage
        .compactMap{ $0 }
        .removeDuplicates()
        .eraseToAnyPublisher()
    
    public init(_ urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        self.urlSession = URLSession(
            configuration: .ephemeral,
            delegate: delegateWrapper,
            delegateQueue: nil
        )
        
        delegateWrapper.didOpenPublisher.sink { [weak self] _ in
            self?.isConnected = true
            self?.receiveMessage()
        }.store(in: &bag)
        
        delegateWrapper.didClosePublisher.sink { [weak self] _, _ in
            self?.isConnected = false
            self?.lastMessage = nil
            self?.lastError = nil
        }.store(in: &bag)
        
        Signal.suspendAll.sink { [weak self] in
            if self?.task?.state == .running {
                self?.task?.suspend()
            }
        }.store(in: &bag)
        
        Signal.resumeAll.sink { [weak self] in
            if self?.task?.state == .suspended {
                self?.task?.resume()
            }
        }.store(in: &bag)
    }
    
    public func connect() {
        guard !isConnected else { return }
        task = urlSession.webSocketTask(with: urlRequest)
        task?.resume()
    }
    
    public func disconnect() {
        guard isConnected else { return }
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }
    
    public func sendMessage(_ message: Message) {
        guard let task else { return }
        task.send(message) { [weak self] error in
            if let error {
                self?.lastError = error
            }
        }
    }
    
    private func receiveMessage() {
        guard let task else { return }
        
        task.receive { [weak self] result in
            switch result {
            case .success(let message):
                self?.lastMessage = message
                self?.receiveMessage()
            case .failure(let error):
                self?.lastError = error
            }
        }
    }
    
    
    private final class DelegateWrapper: NSObject, URLSessionWebSocketDelegate {
        
        typealias ProtocolString = String
        
        private let didOpenPassthrough = PassthroughSubject<ProtocolString?, Never>()
        private let didClosePassthrough = PassthroughSubject<(URLSessionWebSocketTask.CloseCode, Data?), Never>()
        
        lazy var didOpenPublisher: AnyPublisher<ProtocolString?, Never> = didOpenPassthrough.eraseToAnyPublisher()
        lazy var didClosePublisher: AnyPublisher<(URLSessionWebSocketTask.CloseCode, Data?), Never> = didClosePassthrough.eraseToAnyPublisher()
        
        public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
            didOpenPassthrough.send(`protocol`)
        }
        
        public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
            didClosePassthrough.send((closeCode, reason))
        }
        
    }
    
}


extension URLSessionWebSocketTask.Message : @retroactive Equatable {
    
    var data: Data {
        switch self {
        case .string(let string): string.data(using: .utf8) ?? Data()
        case .data(let data): data
        @unknown default: Data()
        }
    }
    
    public static func == (lhs: URLSessionWebSocketTask.Message, rhs: URLSessionWebSocketTask.Message) -> Bool {
        lhs.data == rhs.data
    }
    
}


#endif
