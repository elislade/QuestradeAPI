

public struct StrategyQuote: Equatable, Codable, Sendable {
    
    public let variantId: Int
    public let bidPrice: Double
    public let askPrice: Double
    public let underlying: String
    public let underlyingId: Int
    public let openPrice: Double
    public let volatility: Double
    public let delta: Double
    public let gamma: Double
    public let theta: Double
    public let vega: Double
    public let rho: Double
    public let isRealTime: Bool
    
    public nonisolated init(
        variantId: Int,
        bidPrice: Double,
        askPrice: Double,
        underlying: String,
        underlyingId: Int,
        openPrice: Double,
        volatility: Double,
        delta: Double,
        gamma: Double,
        theta: Double,
        vega: Double,
        rho: Double,
        isRealTime: Bool
    ) {
        self.variantId = variantId
        self.bidPrice = bidPrice
        self.askPrice = askPrice
        self.underlying = underlying
        self.underlyingId = underlyingId
        self.openPrice = openPrice
        self.volatility = volatility
        self.delta = delta
        self.gamma = gamma
        self.theta = theta
        self.vega = vega
        self.rho = rho
        self.isRealTime = isRealTime
    }
    
}
