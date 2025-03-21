

public struct Execution: Equatable, Codable, Identifiable, Sendable {
    
    public let parentId: Int
    public let id: Int
    public let orderId: Int
    public let orderChainId: Int
    public let exchangeExecId: String
    public let symbol: String
    public let symbolId: Int
    public let quantity: Int
    public let side: String
    public let price: Double
    public let timestamp: Date
    public let notes: String
    public let venue: String
    public let totalCost: Double
    public let orderPlacementCommission: Double
    public let commission: Double
    public let executionFee: Double
    public let secFee: Double
    public let canadianExecutionFee: Double
    
    public nonisolated init(
        parentId: Int,
        id: Int,
        orderId: Int,
        orderChainId: Int,
        exchangeExecId: String,
        symbol: String,
        symbolId: Int,
        quantity: Int,
        side: String,
        price: Double,
        timestamp: Date,
        notes: String,
        venue: String,
        totalCost: Double,
        orderPlacementCommission: Double,
        commission: Double,
        executionFee: Double,
        secFee: Double,
        canadianExecutionFee: Double
    ) {
        self.parentId = parentId
        self.id = id
        self.orderId = orderId
        self.orderChainId = orderChainId
        self.exchangeExecId = exchangeExecId
        self.symbol = symbol
        self.symbolId = symbolId
        self.quantity = quantity
        self.side = side
        self.price = price
        self.timestamp = timestamp
        self.notes = notes
        self.venue = venue
        self.totalCost = totalCost
        self.orderPlacementCommission = orderPlacementCommission
        self.commission = commission
        self.executionFee = executionFee
        self.secFee = secFee
        self.canadianExecutionFee = canadianExecutionFee
    }
    
}
