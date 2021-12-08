
import Foundation


public struct ServerTime: Decodable {
    public let time: Date
}


public struct Account: Codable, Equatable, Identifiable {
    public var id: String { number }
    
    public let type: AccountType
    public let number: String
    public let status: AccountStatus
    public let isPrimary: Bool
    public let isBilling: Bool
    public let clientAccountType: ClientAccountType
}


public struct Position: Decodable, Identifiable {
    public var id: Int { symbolId }
    
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
}


public struct Balance: Decodable, Equatable {
    public let currency: Currency
    public let cash: Double
    public let marketValue: Double
    public let totalEquity: Double
    public let buyingPower: Double
    public let maintenanceExcess: Double
    public let isRealTime: Bool
}


public struct Execution: Decodable, Identifiable {
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
}


public struct Activity: Decodable {
    public let tradeDate: Date
    public let transactionDate: Date
    public let settlementDate: Date
    public let action: String
    public let symbol: String
    public let symbolId: Int
    public let description: String
    public let currency: String
    public let quantity: Int
    public let price: Double
    public let grossAmount: Double
    public let commission: Double
    public let netAmount: Double
    public let type: String
}


public struct Order: Codable, Identifiable {
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
    public let placementComission: Double?
    
    public let legs: [Leg]
    
    public let strategyType: StrategyType
    public let triggerStopPrice: Double?
    public let orderGroupId: Int
    public let orderClass: OrderClass?
}

public struct OrderImpact: Decodable {
    public let estimatedCommissions: Double
    public let buyingPowerEffect: Double
    public let buyingPowerResult: Double
    public let maintExcessEffect: Double
    public let maintExcessResult: Double
    public let side: OrderSide
    public let tradeValueCalculation: String
    public let price: Double
}

public struct Option: Decodable {
    public let expiryDate: Date
    public let description: String
    public let listingExchange: ListingExchange
    public let optionExerciseType: OptionExercise
    public let chainPerRoot: [ChainPerRoot]
    
    public struct ChainPerRoot: Decodable {
        public let root: String
        public let chainPerStrikePrice: [ChainPerStrikePrice]
        public let multiplier: Int
        
        public struct ChainPerStrikePrice: Decodable {
            public let strikePrice: Double
            public let callSymbolId: Int
            public let putSymbolId: Int
        }
    }
}


public struct OptionIdFilter: Codable {
    public let optionType: OptionType
    public let underlyingId: Int
    public let expiryDate: Date
    public var minstrikePrice: Double = 0
    public var maxstrikePrice: Double = 0
}

public struct OptionQuote: Decodable {
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
    public let lastTradeTick: Tick
    public let lastTradeTime: Date
    
    public let volume: Int
    public let openPrice: Double
    public let highPrice: Double
    public let lowPrice: Double
    
    public let volatility: Double
    public let delta: Double
    public let gamma: Double
    public let theta: Double
    public let vega: Double
    public let rho: Double
    
    public let openInterest: Int
    public let delay: Int
    public let isHalted: Bool
    public let VWAP: Double
}


public struct EquitySymbol: Codable, Equatable {
    public let symbol: String
    public let symbolId: Int
    public let description: String
    public let securityType: Security
    public let listingExchange: ListingExchange
    public let isQuotable: Bool
    public let isTradable: Bool
    public let currency: String
}


public struct Quote: Decodable, Identifiable {
    public var id: Int { symbolId }
    
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
}


public struct StratagyQuote: Decodable {
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
}

public struct StrategyVariant: Encodable {
    public let variantId: Int
    public let strategy: StrategyType
    public let legs: [Leg]
}


public struct Leg: Codable {
    public let symbolId: Int
    public let action: OrderAction
    public let ratio: Int
}


public struct Symbol: Decodable {
    public let symbol: String
    public let symbolId: Int
    public let prevDayClosePrice: Double?
    public let highPrice52: Double?
    public let lowPrice52: Double?
    public let averageVol3Months: Int?
    public let averageVol20Days: Int?
    public let outstandingShares: Int?
    public let eps: Double?
    public let pe: Double?
    public let dividend: Double
    public let yield: Double
    public let exDate: Date?
    public let marketCap: Double?
    public let optionType: OptionType?
    public let optionDurationType: OptionDuration?
    public let optionRoot: String
    public let optionExerciseType: OptionExercise?
    public let listingExchange: ListingExchange
    public let description: String
    public let securityType: Security
    public let optionExpiryDate: Date?
    public let dividendDate: Date?
    public let optionStrikePrice: Double?
    public let isQuotable: Bool
    public let hasOptions: Bool
    public let currency: String
    public let minTicks: [Tick]
}


public struct Tick: Decodable {
    public let pivot: Double
    public let minTick: Double
}


public struct Candle: Decodable, Equatable {
    public let start: Date
    public let end: Date
    public let open: Double
    public let high: Double
    public let low: Double
    public let close: Double
    public let volume: Int
}


public struct Market: Decodable {
    public let name: String
    public let tradingVenues: [String]
    public let defaultTradingVenue: String
    public let primaryOrderRoutes: [String]
    public let secondaryOrderRoutes: [String]
    public let level1Feeds: [String]
    public let level2Feeds: [String]
    public let extendedStartTime: Date
    public let startTime: Date
    public let endTime: Date
    public let currency: String
    public let snapQuotesLimit: Int
}
