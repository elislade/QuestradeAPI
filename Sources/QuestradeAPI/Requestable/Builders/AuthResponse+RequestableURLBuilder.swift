

extension AuthResponse: RequestableURLBuilder {
    
    public enum Error: Swift.Error {
        case invalidURL
    }
    
    public nonisolated func build<Request>(_ request: Request) throws -> URLRequest where Request : Requestable {
        guard let url = request.resolveURL(fallbackHost: apiServer.absoluteString) else {
            throw Error.invalidURL
        }
        
        var r = URLRequest(url: url)
        r.httpMethod = request.method.rawValue
        
        if let body = request.body {
            r.httpBody = body
        }
        
        r.addValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")

        return r
    }
    
}
