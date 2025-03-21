

public struct AuthURLRequest: Equatable, Codable {
    
    public var clientId: String
    public var callbackURL: URL
    
    public nonisolated init(clientId: String, callbackURL: URL) {
        self.clientId = clientId
        self.callbackURL = callbackURL
    }
    
    public typealias Response = AuthResponse
    
}


extension AuthURLRequest: Requestable {
    
    public nonisolated var host: String? { URL.questLoginHost.absoluteString }
    public nonisolated var endpoint: String { "/oauth2/authorize" }
    public nonisolated var params: [String: String] {
        [
            "redirect_uri" : callbackURL.absoluteString,
            "response_type" : "token",
            "client_id" : clientId
        ]
    }
    
}


public struct AuthToken: Equatable, Codable, Sendable {
    public let expiryDate: Date
    public let response: AuthResponse
    
    public nonisolated init(_ res: AuthResponse){
        self.expiryDate = Date().addingTimeInterval(Double(res.expiresIn))
        self.response = res
    }
}


public struct AuthResponse: Equatable, Codable, Sendable {
    
    public enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case apiServer = "api_server"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
    
    public let accessToken: String
    public let refreshToken: String
    public let apiServer: URL
    public let tokenType: String
    public let expiresIn: Int
    
    public nonisolated init(
        accessToken: String,
        refreshToken: String,
        apiServer: URL,
        tokenType: String,
        expiresIn: Int
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.apiServer = apiServer
        self.tokenType = tokenType
        self.expiresIn = expiresIn
    }
    
    public nonisolated init?(oauthURL url: URL){
        let u = url.absoluteString.replacingOccurrences(of: "#", with: "?")
        guard let items = URLComponents(string: u)?.queryItems else { return nil }
        let d = items.reduce(into: [String: String]()) { $0[$1.name] = $1.value }
        
        guard
            let access = d["access_token"],
            let refresh = d["refresh_token"],
            let apiURL = URL(string: d["api_server"] ?? ""),
            let exp = Double(d["expires_in"] ?? ""),
            let type = d["token_type"]
        else { return nil }
        
        self.accessToken = access
        self.refreshToken = refresh
        self.apiServer = apiURL
        self.tokenType = type
        self.expiresIn = Int(exp)
    }
    
    public nonisolated var oauthURL: URL {
        var c = URLComponents(url: .questAuthBase, resolvingAgainstBaseURL: false)!
        c.queryItems = queryItems
        return c.url!
    }
    
}
