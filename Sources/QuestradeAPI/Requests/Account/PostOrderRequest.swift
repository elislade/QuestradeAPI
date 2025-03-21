

public struct PostOrderRequest: Equatable, Codable, Sendable {
    
    public var accountNumber: AccountNumber
    public var symbolId: Int
    public var qunantity: Int
    public var iceburgQuantity: Int
    public var limitPrice: Double
    public var isAllOrNone: Bool
    public var isAnominous: Bool
    public var orderType: OrderType
    public var timeInForce: OrderTimeInForce
    public var action: OrderAction
    public var primaryRoute: String
    public var secondaryRoute: String
    
    public nonisolated init(
        accountNumber: AccountNumber,
        symbolId: Int,
        qunantity: Int = 0,
        iceburgQuantity: Int = 0,
        limitPrice: Double = 0,
        isAllOrNone: Bool = false,
        isAnominous: Bool = false,
        orderType: OrderType = .limit,
        timeInForce: OrderTimeInForce = .day,
        action: OrderAction = .buy,
        primaryRoute: String = "AUTO",
        secondaryRoute: String = "AUTO"
    ) {
        self.accountNumber = accountNumber
        self.symbolId = symbolId
        self.qunantity = qunantity
        self.iceburgQuantity = iceburgQuantity
        self.limitPrice = limitPrice
        self.isAllOrNone = isAllOrNone
        self.isAnominous = isAnominous
        self.orderType = orderType
        self.timeInForce = timeInForce
        self.action = action
        self.primaryRoute = primaryRoute
        self.secondaryRoute = secondaryRoute
    }
    
}


extension PostOrderRequest: Requestable {
    
    public typealias Response = OrderRequest.Response
    
    public nonisolated var endpoint: String {
        "/v1/accounts/\(accountNumber)/orders"
    }
    
    public nonisolated var method: RequestMethod { .post }
    
    public nonisolated var body: Data? {
        try? QuestEncoder().encode(self)
    }
    
}
