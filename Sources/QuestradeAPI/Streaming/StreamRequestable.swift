

public protocol StreamRequestable : Requestable {
    
    var stream: AsyncThrowingStream<Response, Error>{ get }
    
}


public extension StreamRequestable where Handler : StreamRequestableHandler {
    
    nonisolated var stream: AsyncThrowingStream<Response, Error> {
        handler.perform(self)
    }
    
}


public protocol StreamRequestableHandler {
    
    nonisolated func perform<Request: StreamRequestable>(_ request: Request) -> AsyncThrowingStream<Request.Response, Error>
    
}
