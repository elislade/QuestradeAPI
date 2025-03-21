

public struct AccountsRequest {
    
    public nonisolated init() {}
    
    public struct Response: Equatable, Codable, Identifiable, Sendable {
        
        public nonisolated var id: Int { userId }
        
        public let userId: Int
        public let accounts: [Account]
        
    }
    
}

extension AccountsRequest: Requestable {
    
    public nonisolated var endpoint: String { "/v1/accounts" }
    
}
