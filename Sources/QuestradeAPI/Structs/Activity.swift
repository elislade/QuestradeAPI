

public struct Activity: Equatable, Codable, Sendable {
    
    public let tradeDate: Date
    public let transactionDate: Date
    public let settlementDate: Date
    public let action: String
    public let symbol: String
    public let symbolId: Int
    public let description: String
    public let currency: Currency
    public let quantity: Int
    public let price: Double
    public let grossAmount: Double
    public let commission: Double
    public let netAmount: Double
    public let type: String
    
    public nonisolated init(
        tradeDate: Date,
        transactionDate: Date,
        settlementDate: Date,
        action: String,
        symbol: String,
        symbolId: Int,
        description: String,
        currency: Currency,
        quantity: Int,
        price: Double,
        grossAmount: Double,
        commission: Double,
        netAmount: Double,
        type: String
    ) {
        self.tradeDate = tradeDate
        self.transactionDate = transactionDate
        self.settlementDate = settlementDate
        self.action = action
        self.symbol = symbol
        self.symbolId = symbolId
        self.description = description
        self.currency = currency
        self.quantity = quantity
        self.price = price
        self.grossAmount = grossAmount
        self.commission = commission
        self.netAmount = netAmount
        self.type = type
    }
    
}
