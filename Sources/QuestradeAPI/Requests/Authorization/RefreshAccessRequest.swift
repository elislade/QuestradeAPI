

public struct RefreshAccessRequest: Equatable, Codable {
    
    public var refreshToken: String
    
    public nonisolated init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    public typealias Response = AuthResponse
    
}


extension RefreshAccessRequest : Requestable {
    
    public nonisolated var host: String? { URL.questLoginHost.absoluteString }
    public nonisolated var endpoint: String { "/oauth2/token" }
    public nonisolated var params: [String : String] {
        [
            "grant_type" : "refresh_token",
            "refresh_token" : refreshToken
        ]
    }
    
}

