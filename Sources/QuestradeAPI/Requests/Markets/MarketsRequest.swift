

public struct MarketsRequest {
    
    public nonisolated init(){ }
    
    public struct Response: Codable, Sendable {
        public let markets: [Market]
    }
    
}


extension MarketsRequest: Requestable {
    
    public nonisolated var endpoint: String { "/v1/markets" }
    
}
