
import Foundation


public enum Currency: String, Codable, CaseIterable {
    case USD, CAD
}

public enum ListingExchange: String, Codable, CaseIterable {
    case TSX, TSXV, CNSX, MX, NASDAQ, NYSE, AMEX, ARCA, OPRA, PinkSheets, OTCBB, NYSEAM, PINX, TSXI, DJI, NYSEGIF, NASDAQI, BATS, RUSSELL, NEO, OPRAI, ISEI, PHLXI, SP = "S&P", Empty = ""
}

public enum AccountType: String, Codable, CaseIterable {
    case Cash, Margin, TFSA, RRSP, SRRSP, LRRSP, LIRA, LIF, RIF, SRIF, LRIF,
    RRIF, PRIF, RESP, FRESP
}

public enum ClientAccountType: String, Codable, CaseIterable {
    case Individual, Joint, InformalTrust, Corporation, InvestmentClub, FormalTrust, Partnership,
    SoleProprietorship, FamilyJointandInformalTrust, Institution
}

public enum AccountStatus: String, Codable, CaseIterable {
    case Active, SuspendedClosed, SuspendedViewOnly, Liqudated, Closed
}

public enum TickType: String, Codable, CaseIterable {
    case Up, Down, Equal
}

public enum OptionType: String, Codable, CaseIterable {
    case Call, Put
}

public enum OptionDuration: String, Codable, CustomStringConvertible, CaseIterable {
    case Weekly, Monthly, Quarterly, LEAP
    
    public var description: String {
        return self == .LEAP ? "Long-term equity appreciation contracts" : rawValue
    }
}

public enum OptionExercise: String, Codable, CaseIterable {
    case American, European
}

public enum Security: String, Codable, CaseIterable {
    case Stock, Option, Bond, Right, Gold, MutualFund, Index, Currency
}

public enum OrderAction: String, Codable, CaseIterable {
    case Buy, Sell
}

public enum OrderSide: String, Codable, CustomStringConvertible, CaseIterable {
    case Buy, Sell, Short, Cov, BTO, STC, STO, BTC
    
    public var description: String {
        switch self {
        case .Short: return "Sell short"
        case .Cov: return "Cover the short"
        case .BTO: return "Buy-To-Open"
        case .STC: return "Sell-To-Close"
        case .STO: return "Sell-To-Open"
        case .BTC: return "Buy-To-Close"
        default: return rawValue
        }
    }
}

public enum OrderType: String, Codable, CaseIterable {
    case Market, Limit, Stop, StopLimit, TrailStopInPercentage, TrailStopInDollar,
    TrailStopLimitInPercentage, TrailStopLimitInDollar, LimitOnOpen, LimitOnClose
}

public enum OrderTimeInForce: String, Codable, CaseIterable {
    case Day, GoodTillCanceled, GoodTillExtendedDay, GoodTillDate, ImmediateOrCancel, FillOrKill
}

public enum OrderState: String, Codable, CaseIterable {
    case Failed, Pending, Accepted, Rejected, CancelPending, Canceled, PartialCanceled, Partial, Executed, ReplacePending,
    Replaced, Stopped, Suspended, Expired, Queued, Triggered, Activated, PendingRiskReview
}

public enum HistoricalDataGranularity: String, Codable, CaseIterable {
    case OneMinute, TwoMinutes, ThreeMinutes, FourMinutes, FiveMinutes, TenMinutes, FifteenMinutes, TwentyMinutes,
    HalfHour, OneHour, TwoHours, FourHours,
    OneDay, OneWeek, OneMonth, OneYear
}

public enum OrderClass: String, Codable, CaseIterable {
    case Primary, Limit, StopLoss
}

public enum StrategyType: String, Codable, CaseIterable {
    case SingleLeg, CoveredCall, MarriedPuts, VerticalCallSpread, VerticalPutSpread,
    CalendarCallSpread, CalendarPutSpread, DiagonalCallSpread, DiagonalPutSpread, Collar,
    Straddle, Strangle, ButterflyCall, ButterflyPut, IronButterfly, CondorCall, Custom
}
