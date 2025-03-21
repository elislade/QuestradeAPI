

public struct SymbolsRequest: Equatable, Codable {
    
    public var symbolIds: Set<Int>
    
    public nonisolated init(symbolId: Int) {
        self.symbolIds = [symbolId]
    }
    
    public nonisolated init(symbolIds: Set<Int>) {
        self.symbolIds = symbolIds
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let symbols: [Symbol]
    }
    
}


extension SymbolsRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/symbols\(symbolIds.count == 1 ? "/\(symbolIds.first!)" : "")"
    }
    
    public nonisolated var params: [String : String] {
        if symbolIds.count > 1 {
            ["ids" : symbolIds.map{ String($0) }.joined(separator: ",") ]
        } else {
            [:]
        }
    }
    
}
