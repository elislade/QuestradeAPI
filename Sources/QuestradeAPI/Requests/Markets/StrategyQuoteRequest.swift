

public struct StrategyQuoteRequest: Equatable, Codable {
    
    public var variants: [Variant]
    
    public nonisolated init(variants: [Variant]) {
        self.variants = variants
    }
    
    public struct Variant: Equatable, Codable, Sendable {
        public var variantId: Int
        public var strategy: StrategyType
        public var legs: [Leg]
        
        public struct Leg: Equatable, Codable, Sendable, BitwiseCopyable {
            
            public var symbolId: Int
            public var action: OrderAction
            public var ratio: Int
            
            public nonisolated init(symbolId: Int, action: OrderAction, ratio: Int) {
                self.symbolId = symbolId
                self.action = action
                self.ratio = ratio
            }
            
        }
        
        public nonisolated init(variantId: Int, strategy: StrategyType, legs: [Leg]) {
            self.variantId = variantId
            self.strategy = strategy
            self.legs = legs
        }
    }
    
    public struct Response: Equatable, Codable {
        public let strategyQuotes: [StrategyQuote]
    }
    
}


extension StrategyQuoteRequest: StreamRequestable {
    
    public nonisolated var endpoint: String {
        "/v1/markets/quotes/strategies"
    }
    
    public nonisolated var method: RequestMethod { .post }
    
    public nonisolated var body: Data? {
        try? QuestEncoder().encode(self)
    }
    
}
