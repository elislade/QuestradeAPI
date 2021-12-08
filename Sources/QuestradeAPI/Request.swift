
import Foundation

public struct Request {
    
    public enum Version: String { case v1 }
    public enum Method: String { case GET, POST, UPDATE, CREATE, DELETE }
    
    public let version: Version
    public let endpoint: String
    public var method: Method?
    public var body: Data?
    
    public init(_ endpoint: String, version: Version = .v1, method: Method? = nil, body: Data? = nil){
        self.version = version
        self.endpoint = endpoint
        self.method = method
        self.body = body
    }
    
    public func resolveURLRequest(from auth: AuthResponse) -> URLRequest {
        let url = URL(string: version.rawValue + endpoint, relativeTo: auth.api_server)!
        var r = URLRequest(url: url)
        
        if let method = method {
            r.httpMethod = method.rawValue
        }
        
        if let body = body {
            r.httpBody = body
        }
        
        r.addValue("\(auth.token_type) \(auth.access_token)", forHTTPHeaderField: "Authorization")
        return r
    }
}
