

public struct Quote: Equatable, Codable, Sendable {
    
    public let symbol: String
    public let symbolId: Int
    public let tier: String
    
    public let bidPrice: Double?
    public let bidSize: Int
    public let askPrice: Double?
    public let askSize: Int
    
    public let lastTradePriceTrHrs: Double?
    public let lastTradePrice: Double?
    public let lastTradeSize: Int
    public let lastTradeTime: Date
    public let lastTradeTick: TickType
    
    public let volume: Int
    public let openPrice: Double
    public let highPrice: Double
    public let lowPrice: Double
    
    public let delay: Int
    public let isHalted: Bool
    
    public nonisolated init(
        symbol: String,
        symbolId: Int,
        tier: String,
        bidPrice: Double?,
        bidSize: Int,
        askPrice: Double?,
        askSize: Int,
        lastTradePriceTrHrs: Double?,
        lastTradePrice: Double?,
        lastTradeSize: Int,
        lastTradeTime: Date,
        lastTradeTick: TickType,
        volume: Int,
        openPrice: Double,
        highPrice: Double,
        lowPrice: Double,
        delay: Int,
        isHalted: Bool
    ) {
        self.symbol = symbol
        self.symbolId = symbolId
        self.tier = tier
        self.bidPrice = bidPrice
        self.bidSize = bidSize
        self.askPrice = askPrice
        self.askSize = askSize
        self.lastTradePriceTrHrs = lastTradePriceTrHrs
        self.lastTradePrice = lastTradePrice
        self.lastTradeSize = lastTradeSize
        self.lastTradeTime = lastTradeTime
        self.lastTradeTick = lastTradeTick
        self.volume = volume
        self.openPrice = openPrice
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.delay = delay
        self.isHalted = isHalted
    }
    
}
