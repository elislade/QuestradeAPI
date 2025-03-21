

public struct PostOrderImpactRequest: Codable, Equatable {
    
    public var symbolId: Int
    public var quantity: Int
    public var orderType: OrderType
    public var timeInForce: OrderTimeInForce
    public var action: OrderAction
    public var primaryRoute: String
    public var secondaryRoute: String
    
    public nonisolated init(
        symbolId: Int,
        quantity: Int = 100,
        orderType: OrderType = .limit,
        timeInForce: OrderTimeInForce = .day,
        action: OrderAction = .buy,
        primaryRoute: String = "",
        secondaryRoute: String = ""
    ) {
        self.symbolId = symbolId
        self.quantity = quantity
        self.orderType = orderType
        self.timeInForce = timeInForce
        self.action = action
        self.primaryRoute = primaryRoute
        self.secondaryRoute = secondaryRoute
    }
    
}


extension PostOrderImpactRequest: Requestable {
    
    public typealias Response = OrderRequest.Response
    
    public nonisolated var endpoint: String {
        "/v1/orders/impact"
    }
    
    public nonisolated var method: RequestMethod { .post }

    public nonisolated var body: Data? {
        try? QuestEncoder().encode(self)
    }
    
}
