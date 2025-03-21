

public protocol RequestableHandler {
    
    var urlSession: URLSession { get set }
    var requestBuilder: any RequestableURLBuilder { get set }
    var responseParser: any ResponseParser { get set }
    
    func perform<Request: Requestable>(_ request: Request) async throws -> Request.Response
    
}

open class URLRequestHandler: RequestableHandler {
    
    open var urlSession: URLSession = .shared
    open var requestBuilder: any RequestableURLBuilder = .default
    open var responseParser: any ResponseParser = .default
    
    @discardableResult open func perform<Request: Requestable>(_ request: Request) async throws -> Request.Response {
        let urlRequest = try requestBuilder.build(request)
        let responseTuple = try await urlSession.data(for: urlRequest)
        return try responseParser.parse(responseTuple.0)
    }
    
}
