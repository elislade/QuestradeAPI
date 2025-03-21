

public struct Symbol: Equatable, Codable, Identifiable, Sendable {
    
    public nonisolated var id: Int { symbolId }
    
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
    public let currency: Currency
    public let minTicks: [Tick]
    
    public nonisolated init(
        symbol: String,
        symbolId: Int,
        prevDayClosePrice: Double?,
        highPrice52: Double?,
        lowPrice52: Double?,
        averageVol3Months: Int?,
        averageVol20Days: Int?,
        outstandingShares: Int?,
        eps: Double?,
        pe: Double?,
        dividend: Double,
        yield: Double,
        exDate: Date?,
        marketCap: Double?,
        optionType: OptionType?,
        optionDurationType: OptionDuration?,
        optionRoot: String,
        optionExerciseType: OptionExercise?,
        listingExchange: ListingExchange,
        description: String,
        securityType: Security,
        optionExpiryDate: Date?,
        dividendDate: Date?,
        optionStrikePrice: Double?,
        isQuotable: Bool,
        hasOptions: Bool,
        currency: Currency,
        minTicks: [Tick]
    ) {
        self.symbol = symbol
        self.symbolId = symbolId
        self.prevDayClosePrice = prevDayClosePrice
        self.highPrice52 = highPrice52
        self.lowPrice52 = lowPrice52
        self.averageVol3Months = averageVol3Months
        self.averageVol20Days = averageVol20Days
        self.outstandingShares = outstandingShares
        self.eps = eps
        self.pe = pe
        self.dividend = dividend
        self.yield = yield
        self.exDate = exDate
        self.marketCap = marketCap
        self.optionType = optionType
        self.optionDurationType = optionDurationType
        self.optionRoot = optionRoot
        self.optionExerciseType = optionExerciseType
        self.listingExchange = listingExchange
        self.description = description
        self.securityType = securityType
        self.optionExpiryDate = optionExpiryDate
        self.dividendDate = dividendDate
        self.optionStrikePrice = optionStrikePrice
        self.isQuotable = isQuotable
        self.hasOptions = hasOptions
        self.currency = currency
        self.minTicks = minTicks
    }
    
}


public struct Tick: Equatable, Codable, Sendable, BitwiseCopyable {
    
    public let pivot: Double
    public let minTick: Double
    
    public nonisolated init(pivot: Double, minTick: Double) {
        self.pivot = pivot
        self.minTick = minTick
    }
    
}
