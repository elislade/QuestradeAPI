
#if canImport(Combine)

import Combine

extension URLRequestHandler : StreamRequestableHandler {
    
    public func perform<Request: StreamRequestable>(_ request: Request) -> AsyncThrowingStream<Request.Response, Error> {
        AsyncThrowingStream { [unowned self] continuation in
            Task.detached { [unowned self] in
                do {
                    let port = try await request.streamPort()
                    let requestWithPort = request.withConcrete(\.port, value: port)
                    let urlRequest = try requestBuilder.build(requestWithPort)
                    let manager = SocketManager(urlRequest)
                    
                    let connectedCancellable = manager.isConnectedPublisher.sink {
                        if !$0 {
                            continuation.finish()
                        }
                    }
                    
                    let messageCancellable = manager.messagesPublisher.sink{ [unowned self] message in
                        if let response: Request.Response = try? responseParser.parse(message.data){
                            continuation.yield(response)
                        }
                    }
                    
                    manager.connect()
                    
                    if let auth = urlRequest.value(forHTTPHeaderField: "Authorization") {
                        let unbeareredAuth = auth.replacingOccurrences(of: "Bearer ", with: "")
                        manager.sendMessage(.string(unbeareredAuth))
                    }
                    
                    continuation.onTermination = { _ in
                        connectedCancellable.cancel()
                        messageCancellable.cancel()
                        manager.disconnect()
                    }
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
        
    }
    
}

#endif
