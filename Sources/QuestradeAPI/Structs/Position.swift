

public struct Position: Equatable, Codable, Sendable {
    
    public let symbol: String
    public let symbolId: Int
    public let openQuantity: Double
    public let closedQuantity: Double
    public let currentMarketValue: Double
    public let currentPrice: Double
    public let averageEntryPrice: Double
    public let closedPnl: Double
    public let openPnl: Double
    public let totalCost: Double
    public let isRealTime: Bool
    public let isUnderReorg: Bool
    
    public nonisolated init(
        symbol: String,
        symbolId: Int,
        openQuantity: Double,
        closedQuantity: Double,
        currentMarketValue: Double,
        currentPrice: Double,
        averageEntryPrice: Double,
        closedPnl: Double,
        openPnl: Double,
        totalCost: Double,
        isRealTime: Bool,
        isUnderReorg: Bool
    ) {
        self.symbol = symbol
        self.symbolId = symbolId
        self.openQuantity = openQuantity
        self.closedQuantity = closedQuantity
        self.currentMarketValue = currentMarketValue
        self.currentPrice = currentPrice
        self.averageEntryPrice = averageEntryPrice
        self.closedPnl = closedPnl
        self.openPnl = openPnl
        self.totalCost = totalCost
        self.isRealTime = isRealTime
        self.isUnderReorg = isUnderReorg
    }
    
}
