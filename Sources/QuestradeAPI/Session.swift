
#if canImport(Combine)

import Combine

public final class Session: URLRequestHandler, ObservableObject {
    
    public static let shared: Session = Session()
    
    private var forceTokenRefresh: Bool = false
    
    @Published public private(set) var errors: [LoggedError] = []
    
    internal override init(){
        super.init()
        responseParser = .quest
    }
    
    @Published public var token: AuthToken? {
        didSet {
            if let token {
                requestBuilder = token.response
            } else {
                clear()
            }
        }
    }
    
    public override func perform<Request: Requestable>(_ request: Request) async throws -> Request.Response {
        do {
            try await refreshIfNeeded()
            return try await super.perform(request)
        } catch {
            if
                let questError = error as? QuestError,
                questError.code == .accessTokenInvalid
            {
                forceTokenRefresh = true
                return try await perform(request)
            } else {
                Task { @MainActor [weak self] in
                    self?.errors.append(LoggedError(request: request, error))
                }
                throw error
            }
        }
    }
    
    private func refreshIfNeeded() async throws {
        guard let token else { return }
 
        if token.expiryDate < Date() || forceTokenRefresh {
            forceTokenRefresh = false
            let refreshRequest = RefreshAccessRequest(
                refreshToken: token.response.refreshToken
            )
            
            do {
                let newToken = try await super.perform(refreshRequest)
                requestBuilder = newToken
                Task { @MainActor [weak self] in
                    self?.token = .init(newToken)
                }
            } catch {
                Task { @MainActor [weak self] in
                    self?.errors.append(LoggedError(request: refreshRequest, error))
                }
            }
        }
    }
    
    public func clear() {
        errors.removeAll()
        if token != nil {
            token = nil
        }
    }
    
    public func revokeAccess() async throws {
        guard token != nil else { return }
        let request = RevokeAccessRequest()
        do {
            try await super.perform(request)
            Task { @MainActor  [weak self] in
                self?.token = nil
                self?.errors = []
            }
        } catch {
            Task { @MainActor [weak self] in
                self?.errors.append(LoggedError(request: request, error))
            }
            throw error
        }
    }
    
}

public extension Requestable {
    
    var handler: Session { Session.shared }
    
    nonisolated func callAsFunction() async throws -> Response {
        try await response()
    }
    
    nonisolated func response() async throws -> Response {
        try await handler.perform(self)
    }
    
}

#endif
