

public struct QuotesRequest: Equatable, Codable {
    
    public var symbolIds: Set<Int>
    
    public nonisolated init(symbolIds: Set<Int>) {
        self.symbolIds = symbolIds
    }
    
    public nonisolated init(symbolId: Int) {
        self.symbolIds = [symbolId]
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let quotes: [Quote]
    }
    
}


extension QuotesRequest: StreamRequestable {
    
    public nonisolated var endpoint: String {
        "/v1/markets/quotes"
    }
    
    public var params: [String : String] {
        ["ids" : symbolIds.map(\.description).joined(separator: ",")]
    }
    
}
