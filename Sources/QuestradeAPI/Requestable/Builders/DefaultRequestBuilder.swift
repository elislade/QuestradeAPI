

public struct DefaultRequestBuilder: RequestableURLBuilder {
    
    public let fallbackHost: String?
    
    public nonisolated init(fallbackHost: String? = nil){
        self.fallbackHost = fallbackHost
    }
    
    public enum Error: Swift.Error {
        case missingHost
    }
    
    public nonisolated func build<Request>(_ request: Request) throws -> URLRequest where Request : Requestable {
        guard let url = request.resolveURL(fallbackHost: fallbackHost) else {
            throw Error.missingHost
        }
        
        var result = URLRequest(url: url)
        result.httpMethod = request.method.rawValue
        
        if let body = request.body {
            result.httpBody = body
        }
        
        return result
    }
    
}


public extension RequestableURLBuilder where Self == DefaultRequestBuilder {
    
    static nonisolated var `default`: Self { DefaultRequestBuilder() }
    
}
