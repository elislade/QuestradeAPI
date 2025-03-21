

public struct OptionQuote: Equatable, Codable, Sendable {
    
    public let underlying: String
    public let underlyingId: Int
    
    public let symbol: String
    public let symbolId: Int
    
    public let bidPrice: Double
    public let bidSize: Int
    public let askPrice: Double
    public let askSize: Int
    
    public let lastTradePriceTrHrs: Double
    public let lastTradePrice: Double
    public let lastTradeSize: Int
    public let lastTradeTime: Date
    public let lastTradeTick: TickType
    
    public let volume: Int
    public let openPrice: Double
    public let highPrice: Double
    public let lowPrice: Double
    
    public let delay: Int
    public let isHalted: Bool
    
    public let volatility: Double
    public let delta: Double
    public let gamma: Double
    public let theta: Double
    public let vega: Double
    public let rho: Double
    
    public let openInterest: Int
    public let VWAP: Double
    
    public nonisolated init(
        underlying: String,
        underlyingId: Int,
        symbol: String,
        symbolId: Int,
        bidPrice: Double,
        bidSize: Int,
        askPrice: Double,
        askSize: Int,
        lastTradePriceTrHrs: Double,
        lastTradePrice: Double,
        lastTradeSize: Int,
        lastTradeTick: TickType,
        lastTradeTime: Date,
        volume: Int,
        openPrice: Double,
        highPrice: Double,
        lowPrice: Double,
        volatility: Double,
        delta: Double,
        gamma: Double,
        theta: Double,
        vega: Double,
        rho: Double,
        openInterest: Int,
        delay: Int,
        isHalted: Bool,
        VWAP: Double
    ) {
        self.underlying = underlying
        self.underlyingId = underlyingId
        self.symbol = symbol
        self.symbolId = symbolId
        self.bidPrice = bidPrice
        self.bidSize = bidSize
        self.askPrice = askPrice
        self.askSize = askSize
        self.lastTradePriceTrHrs = lastTradePriceTrHrs
        self.lastTradePrice = lastTradePrice
        self.lastTradeSize = lastTradeSize
        self.lastTradeTick = lastTradeTick
        self.lastTradeTime = lastTradeTime
        self.volume = volume
        self.openPrice = openPrice
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.volatility = volatility
        self.delta = delta
        self.gamma = gamma
        self.theta = theta
        self.vega = vega
        self.rho = rho
        self.openInterest = openInterest
        self.delay = delay
        self.isHalted = isHalted
        self.VWAP = VWAP
    }
    
}
