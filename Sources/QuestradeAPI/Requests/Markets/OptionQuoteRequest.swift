

public struct OptionQuoteRequest: Equatable, Codable {
    
    public var filters: [IDFilter]
    public var optionIds: Set<Int>
    
    public nonisolated init(filters: [IDFilter], optionIds: Set<Int> = []) {
        self.filters = filters
        self.optionIds = optionIds
    }
    
    public struct IDFilter: Equatable, Codable, Sendable {
        
        public var optionType: OptionType
        public var underlyingId: Int
        public var expiryDate: Date
        public var minstrikePrice: Double
        public var maxstrikePrice: Double
        
        public nonisolated init(
            optionType: OptionType,
            underlyingId: Int,
            expiryDate: Date,
            minstrikePrice: Double = 0,
            maxstrikePrice: Double = 1
        ) {
            self.optionType = optionType
            self.underlyingId = underlyingId
            self.expiryDate = expiryDate
            self.minstrikePrice = minstrikePrice
            self.maxstrikePrice = maxstrikePrice
        }
        
    }
    
    public struct Response: Equatable, Codable {
        public let optionQuotes: [OptionQuote]
    }
    
}


extension OptionQuoteRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/markets/quotes/options"
    }
    
    public nonisolated var method: RequestMethod { .post }
    
    public nonisolated var body: Data? {
        try? QuestEncoder().encode(self)
    }
    
}
