

public struct Order: Equatable, Codable, Identifiable, Sendable {
    
    public let id: Int
    public let symbol: String
    public let symbolId: Int
    public let totalQuantity: Int
    public let openQuantity: Int?
    public let filledQuantity: Int?
    public let canceledQuantity: Int
    public let side: OrderSide
    public let orderType: OrderType
    public let limitPrice: Double?
    public let stopPrice: Double?
    public let isAllOrNone: Bool
    public let isAnonymous: Bool
    public let icebergQuantity: Int?
    public let minQuantity: Int?
    public let avgExecPrice: Double?
    public let lastExecPrice: Double?
    
    public let source: String?
    
    public let timeInForce: OrderTimeInForce
    public let gtdDate: Date?
    public let state: OrderState
    public let clientReasonStr: String?
    public let chainId: Int
    public let creationTime: Date
    public let updateTime: Date
    public let notes: String
    
    public let primaryRoute: String?
    public let secondaryRoute: String?
    public let orderRoute: String?
    public let venueHoldingOrder: String?
    
    public let comissionCharged: Double?
    public let exchangeOrderId: String
    public let isSignificantShareHolder: Bool
    public let isInsider: Bool
    public let isLimitOffsetInDollar: Bool
    public let userId: Int
    public let placementCommission: Double?
    
    public let legs: [OrderLeg]
    
    public let strategyType: StrategyType?
    public let triggerStopPrice: Double?
    public let orderGroupId: Int
    public let orderClass: OrderClass?
    
    public nonisolated init(
        id: Int,
        symbol: String,
        symbolId: Int,
        totalQuantity: Int,
        openQuantity: Int?,
        filledQuantity: Int?,
        canceledQuantity: Int,
        side: OrderSide,
        orderType: OrderType,
        limitPrice: Double?,
        stopPrice: Double?,
        isAllOrNone: Bool,
        isAnonymous: Bool,
        icebergQuantity: Int?,
        minQuantity: Int?,
        avgExecPrice: Double?,
        lastExecPrice: Double?,
        source: String?,
        timeInForce: OrderTimeInForce,
        gtdDate: Date?,
        state: OrderState,
        clientReasonStr: String?,
        chainId: Int,
        creationTime: Date,
        updateTime: Date,
        notes: String,
        primaryRoute: String?,
        secondaryRoute: String?,
        orderRoute: String?,
        venueHoldingOrder: String?,
        comissionCharged: Double?,
        exchangeOrderId: String,
        isSignificantShareHolder: Bool,
        isInsider: Bool,
        isLimitOffsetInDollar: Bool,
        userId: Int,
        placementCommission: Double?,
        legs: [OrderLeg],
        strategyType: StrategyType,
        triggerStopPrice: Double?,
        orderGroupId: Int,
        orderClass: OrderClass?
    ) {
        self.id = id
        self.symbol = symbol
        self.symbolId = symbolId
        self.totalQuantity = totalQuantity
        self.openQuantity = openQuantity
        self.filledQuantity = filledQuantity
        self.canceledQuantity = canceledQuantity
        self.side = side
        self.orderType = orderType
        self.limitPrice = limitPrice
        self.stopPrice = stopPrice
        self.isAllOrNone = isAllOrNone
        self.isAnonymous = isAnonymous
        self.icebergQuantity = icebergQuantity
        self.minQuantity = minQuantity
        self.avgExecPrice = avgExecPrice
        self.lastExecPrice = lastExecPrice
        self.source = source
        self.timeInForce = timeInForce
        self.gtdDate = gtdDate
        self.state = state
        self.clientReasonStr = clientReasonStr
        self.chainId = chainId
        self.creationTime = creationTime
        self.updateTime = updateTime
        self.notes = notes
        self.primaryRoute = primaryRoute
        self.secondaryRoute = secondaryRoute
        self.orderRoute = orderRoute
        self.venueHoldingOrder = venueHoldingOrder
        self.comissionCharged = comissionCharged
        self.exchangeOrderId = exchangeOrderId
        self.isSignificantShareHolder = isSignificantShareHolder
        self.isInsider = isInsider
        self.isLimitOffsetInDollar = isLimitOffsetInDollar
        self.userId = userId
        self.placementCommission = placementCommission
        self.legs = legs
        self.strategyType = strategyType
        self.triggerStopPrice = triggerStopPrice
        self.orderGroupId = orderGroupId
        self.orderClass = orderClass
    }
    
}



public struct OrderImpact: Equatable, Codable, Sendable {
    
    public let estimatedCommissions: Double
    public let buyingPowerEffect: Double
    public let buyingPowerResult: Double
    public let maintExcessEffect: Double
    public let maintExcessResult: Double
    public let side: OrderSide
    public let tradeValueCalculation: String
    public let price: Double
    
    public nonisolated init(
        estimatedCommissions: Double,
        buyingPowerEffect: Double,
        buyingPowerResult: Double,
        maintExcessEffect: Double,
        maintExcessResult: Double,
        side: OrderSide,
        tradeValueCalculation: String,
        price: Double
    ) {
        self.estimatedCommissions = estimatedCommissions
        self.buyingPowerEffect = buyingPowerEffect
        self.buyingPowerResult = buyingPowerResult
        self.maintExcessEffect = maintExcessEffect
        self.maintExcessResult = maintExcessResult
        self.side = side
        self.tradeValueCalculation = tradeValueCalculation
        self.price = price
    }
    
}
