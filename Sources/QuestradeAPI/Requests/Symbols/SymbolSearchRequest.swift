

public struct SymbolSearchRequest: Equatable, Codable {
    
    public var term: String
    public var offset: Int
    
    public nonisolated init(term: String, offset: Int = 0) {
        self.term = term
        self.offset = offset
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let symbols: [EquitySymbol]
    }
    
}


extension SymbolSearchRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/symbols/search"
    }

    public nonisolated var params: [String : String] {
        ["prefix" : term, "offset": "\(offset)"]
    }

}
