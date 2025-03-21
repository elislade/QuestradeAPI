

public struct SymbolOptionChainRequest: Equatable, Codable {
    
    public var symbolID: Int
    
    public nonisolated init(symbolID: Int) {
        self.symbolID = symbolID
    }
    
    public struct Response: Equatable, Codable {
        public let optionChain: [OptionChainElement]
    }
    
}


extension SymbolOptionChainRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/symbols/\(symbolID)/options"
    }
    
}
