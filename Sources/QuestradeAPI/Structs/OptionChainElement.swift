

public struct OptionChainElement: Equatable, Codable, Sendable {
    
    public let expiryDate: Date
    public let description: String
    public let listingExchange: ListingExchange
    public let optionExerciseType: OptionExercise
    public let chainPerRoot: [RootElement]
    
    public struct RootElement: Equatable, Codable, Sendable {
        
        public let optionRoot: String
        public let chainPerStrikePrice: [StrikePriceElement]
        public let multiplier: Int
        
        public struct StrikePriceElement: Equatable, Codable, Sendable, BitwiseCopyable {
            
            public let strikePrice: Double
            public let callSymbolId: Int
            public let putSymbolId: Int
            
            public nonisolated init(strikePrice: Double, callSymbolId: Int, putSymbolId: Int) {
                self.strikePrice = strikePrice
                self.callSymbolId = callSymbolId
                self.putSymbolId = putSymbolId
            }
            
        }
        
        public nonisolated init(optionRoot: String, chainPerStrikePrice: [StrikePriceElement], multiplier: Int) {
            self.optionRoot = optionRoot
            self.chainPerStrikePrice = chainPerStrikePrice
            self.multiplier = multiplier
        }
        
    }
    
    public nonisolated init(
        expiryDate: Date,
        description: String,
        listingExchange: ListingExchange,
        optionExerciseType: OptionExercise,
        chainPerRoot: [RootElement]
    ) {
        self.expiryDate = expiryDate
        self.description = description
        self.listingExchange = listingExchange
        self.optionExerciseType = optionExerciseType
        self.chainPerRoot = chainPerRoot
    }
    
}
