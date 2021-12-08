
import Foundation


//MARK: - https://login.questrade.com/oauth2/

public struct Auth: Codable {
    let res: AuthResponse
    var expiryDate: Date
}

public struct AuthResponse: Codable {
    public let access_token: String
    public let refresh_token: String
    public let api_server: URL
    public let token_type: String
    public let expires_in: Int
}


//MARK: - /accounts

public struct AccountResponse: Decodable {
    public let userId: Int
    public let accounts: [Account]
}


//MARK: - /accounts/ {{ accountNumber }} /positions

public struct PositionResponse: Decodable {
    public let positions: [Position]
}


//MARK: - /accounts/ {{ accountNumber }} /balances

public struct BalanceResponse: Decodable, Equatable {
    public let perCurrencyBalances: [Balance]
    public let combinedBalances: [Balance]
    
    // sod = start of day
    public let sodPerCurrencyBalances: [Balance]
    public let sodCombinedBalances: [Balance]
    
    public var gains: (value: Double, percent: Double)? {
        guard
            let combinedSod = sodCombinedBalances.first(where: { $0.currency == .CAD }),
            let combined = combinedBalances.first(where: { $0.currency == .CAD })
        else { return nil }
        
        let change = combined.totalEquity - combinedSod.totalEquity
        let percent = change / combinedSod.totalEquity
        
        return(change, percent)
    }
}


//MARK: - /accounts/ {{ accountNumber }} /executions

public struct ExecutionRequest {
    public let accountNumber: Int
    public let dateInterval: DateInterval
    
    public init(accountNumber: Int, dateInterval: DateInterval){
        self.accountNumber = accountNumber
        self.dateInterval = dateInterval
    }
}

public struct ExecutionResponse: Decodable {
    public let executions: [Execution]
}


//MARK: - /accounts/ {{ accountNumber }} /activities

public struct ActivityResponse: Decodable {
    public let activities: [Activity]
}


//MARK: - /accounts/ {{ accountNumber }} /orders

public struct OrderRequest {
    public let accountNumber: String
    public let dateInterval: DateInterval
    public let stateFilter: OrderState?
    public let orderId: Int
    
    public init(accountNumber: String, dateInterval: DateInterval, stateFilter: OrderState? = nil, orderId: Int) {
        self.accountNumber = accountNumber
        self.dateInterval = dateInterval
        self.stateFilter = stateFilter
        self.orderId = orderId
    }
}

public struct OrderResponse: Decodable {
    public let orders: [Order]
}


//MARK: - /accounts/ {{ accountNumber }} /orders

public struct PostOrderRequest: Codable {
    public var accountNumber: String
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
    
    public init() {
        self.accountNumber = ""
        self.symbolId = 0
        self.qunantity = 0
        self.iceburgQuantity = 0
        self.limitPrice = 0
        self.isAllOrNone = true
        self.isAnominous = false
        self.orderType = .Limit
        self.timeInForce = .Day
        self.action = .Buy
        self.primaryRoute = "AUTO"
        self.secondaryRoute = "AUTO"
    }
}

public struct OrderImpactRequest: Codable {
    public var symbolId: Int
    public var quantity: Int
    public var orderType: OrderType
    public var timeInForce: OrderTimeInForce
    public var action: OrderAction
    public var primaryRoute: String
    public var secondaryRoute: String
    
    public init(symbolId: Int, quantity: Int, orderType: OrderType, timeInForce: OrderTimeInForce, action: OrderAction, primaryRoute: String, secondaryRoute: String) {
        self.symbolId = symbolId
        self.quantity = quantity
        self.orderType = orderType
        self.timeInForce = timeInForce
        self.action = action
        self.primaryRoute = primaryRoute
        self.secondaryRoute = secondaryRoute
    }
}


//MARK: - /symbols/search

public struct SearchRequest {
    public var prefix: String
    public var offset: Int
    
    public init(prefix: String, offset: Int) {
        self.prefix = prefix
        self.offset = offset
    }
}

public struct SearchResponse: Decodable {
    public let symbols: [EquitySymbol]
}


//MARK: - /symbols/ {{ symbolID }}

public struct SymbolResponse: Decodable {
    public let symbols: [Symbol]
}


//MARK: - /markets

public struct MarketResponse: Decodable {
    public let markets: [Market]
}


//MARK: - /markets/quotes/ {{ symbolID }}

public struct QuoteResponse: Decodable {
    public let quotes: [Quote]
}


//MARK: - /markets/candles/ {{ symbolID }}

public struct CandleRequest {
    public let symbolID: Int
    public let dateInterval: DateInterval
    public let granularity: HistoricalDataGranularity
    
    public init(symbolID: Int, dateInterval: DateInterval, granularity: HistoricalDataGranularity) {
        self.symbolID = symbolID
        self.dateInterval = dateInterval
        self.granularity = granularity
    }
}

public struct CandleResponse: Decodable {
    public let candles: [Candle]
}


//MARK: - /markets/symbols/ {{ symbolID }} /options

public struct OptionResponse: Decodable {
    public let options: [Option]
}


//MARK: - /markets/quotes/options

public struct OptionRequest: Encodable {
    public let filters: [OptionIdFilter]
    public let optionIds: [Int]
    
    public init(filters: [OptionIdFilter], optionIds: [Int]) {
        self.filters = filters
        self.optionIds = optionIds
    }
}

public struct OptionQuoteResponse: Decodable {
    public let optionQuotes: [OptionQuote]
}


//MARK: - /markets/quotes/strategies

public struct StrategyVariantRequest: Encodable {
    public let variants: [StrategyVariant]
    
    public init(variants: [StrategyVariant]) {
        self.variants = variants
    }
}

public struct StrategyQuoteResponse: Decodable {
    public let stategyQuotes: [StratagyQuote]
}

