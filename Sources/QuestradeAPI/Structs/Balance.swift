

public struct Balance: Equatable, Codable, Sendable {
    
    public let currency: Currency
    public let cash: Double
    public let marketValue: Double
    public let totalEquity: Double
    public let buyingPower: Double
    public let maintenanceExcess: Double
    public let isRealTime: Bool
    
    public nonisolated init(
        currency: Currency,
        cash: Double,
        marketValue: Double,
        totalEquity: Double,
        buyingPower: Double,
        maintenanceExcess: Double,
        isRealTime: Bool
    ) {
        self.currency = currency
        self.cash = cash
        self.marketValue = marketValue
        self.totalEquity = totalEquity
        self.buyingPower = buyingPower
        self.maintenanceExcess = maintenanceExcess
        self.isRealTime = isRealTime
    }
    
}
