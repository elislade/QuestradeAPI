

public enum Currency: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case USD
    case CAD
    
}


public enum ListingExchange: String, CustomStringConvertible, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case TSX, TSXV, CNSX, MX, NASDAQ, NYSE, AMEX, ARCA, OPRA
    case pinkSheets
    case OTCBB, NYSEAM, PINX, TSXI, DJI, NYSEGIF
    case NASDAQI, BATS, RUSSELL, NEO, OPRAI, ISEI, PHLXI
    
    case SP = "S&P"
    case empty = ""
    
    public nonisolated var description: String {
        switch self {
        case .TSX: return "Toronto Stock Exchange"
        case .TSXV: return "TSX Venture Exchange"
        case .CNSX: return "Canadian Securities Exchange"
        case .MX: return "Montreal Exchange"
        case .NASDAQ: return "NASDAQ Stock Market"
        case .NYSE: return "New York Stock Exchange"
        case .AMEX: return "American Stock Exchange"
        case .ARCA: return "NYSE Arca"
        case .OPRA: return "Options Price Reporting Authority"
        case .pinkSheets: return "Pink Sheets"
        case .OTCBB: return "Over-the-Counter Bulletin Board"
        case .NYSEAM: return "NYSE American"
        case .PINX: return "OTC Markets Pink"
        case .TSXI: return "Toronto Stock Exchange Index"
        case .DJI: return "Dow Jones Industrial Average"
        case .NYSEGIF: return "NYSE Global Index Feed"
        case .NASDAQI: return "NASDAQ International"
        case .BATS: return "BATS Global Markets"
        case .RUSSELL: return "Russell Indexes"
        case .NEO: return "NEO Exchange"
        case .OPRAI: return "Options Price Reporting Authority International"
        case .ISEI: return "International Securities Exchange International"
        case .PHLXI: return "Philadelphia Stock Exchange International"
        case .SP: return "Standard & Poor's Index"
        case .empty: return "No Exchange Specified"
        }
    }
    
}


public enum AccountType: String, CustomStringConvertible, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case cash = "Cash"
    case margin = "Margin"
    
    case TFSA, RRSP, SRRSP, LRRSP, LIRA, LIF, RIF, SRIF, LRIF, RRIF, PRIF, RESP, FRESP
    
    public nonisolated var description: String {
        switch self {
        case .cash: return "Cash Account"
        case .margin: return "Margin Account"
        case .TFSA: return "Tax-Free Savings Account"
        case .RRSP: return "Registered Retirement Savings Plan"
        case .SRRSP: return "Spousal Registered Retirement Savings Plan"
        case .LRRSP: return "Locked-In Registered Retirement Savings Plan"
        case .LIRA: return "Locked-In Retirement Account"
        case .LIF: return "Life Income Fund"
        case .RIF: return "Retirement Income Fund"
        case .SRIF: return "Spousal Retirement Income Fund"
        case .LRIF: return "Locked-In Retirement Income Fund"
        case .RRIF: return "Registered Retirement Income Fund"
        case .PRIF: return "Prescribed Retirement Income Fund"
        case .RESP: return "Registered Education Savings Plan"
        case .FRESP: return "Family Registered Education Savings Plan"
        }
    }
    
}


public enum ClientAccountType: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case individual = "Individual"
    case joint = "Joint"
    case informalTrust = "InformalTrust"
    case corporation = "Corporation"
    case investmentClub = "InvestmentClub"
    case formalTrust = "FormalTrust"
    case partnership = "Partnership"
    case soleProprietorship = "SoleProprietorship"
    case familyJointandInformalTrust = "FamilyJointandInformalTrust"
    case institution = "Institution"
    
}


public enum AccountStatus: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case active = "Active"
    case suspendedClosed = "SuspendedClosed"
    case suspendedViewOnly = "SuspendedViewOnly"
    case liqudated = "Liqudated"
    case closed = "Closed"
    
}


public enum TickType: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case up = "Up"
    case down = "Down"
    case equal = "Equal"
    
}


public enum OptionType: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case call = "Call"
    case put = "Put"
    
}


public enum OptionDuration: String, Codable, CustomStringConvertible, CaseIterable, Sendable, BitwiseCopyable {
    
    case weekly = "Weekly"
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case LEAP = "LEAP"
    
    public nonisolated var description: String {
        return self == .LEAP ? "Long-term equity appreciation contracts" : rawValue
    }
    
}


public enum OptionExercise: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case american = "American"
    case european = "European"
    
}


public enum Security: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case stock = "Stock"
    case option = "Option"
    case bond = "Bond"
    case right = "Right"
    case gold = "Gold"
    case mutualFund = "MutualFund"
    case index = "Index"
    case currency = "Currency"
    
}


public enum OrderAction: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case buy = "Buy"
    case sell = "Sell"
    
}


public enum OrderSide: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case buy = "Buy"
    case sell = "Sell"
    case short = "Short"
    case coverShort = "Cov"
    case buyToOpen = "BTO"
    case sellToClose = "STC"
    case sellToOpen = "STO"
    case buyToClose = "BTC"
    
}


public enum OrderType: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case market = "Market"
    case limit = "Limit"
    case stop = "Stop"
    case stopLimit = "StopLimit"
    case trailStopInPercentage = "TrailStopInPercentage"
    case trailStopInDollar = "TrailStopInDollar"
    case trailStopLimitInPercentage = "TrailStopLimitInPercentage"
    case trailStopLimitInDollar = "TrailStopLimitInDollar"
    case limitOnOpen = "LimitOnOpen"
    case limitOnClose = "LimitOnClose"
    
}


public enum OrderTimeInForce: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case day = "Day"
    case goodTillCanceled = "GoodTillCanceled"
    case goodTillExtendedDay = "GoodTillExtendedDay"
    case goodTillDate = "GoodTillDate"
    case immediateOrCancel = "ImmediateOrCancel"
    case fillOrKill = "FillOrKill"
    
}


public enum OrderState: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case failed = "Failed"
    case pending = "Pending"
    case accepted = "Accepted"
    case rejected = "Rejected"
    case cancelPending = "CancelPending"
    case canceled = "Canceled"
    case partialCanceled = "PartialCanceled"
    case partial = "Partial"
    case executed = "Executed"
    case replacePending = "ReplacePending"
    case replaced = "Replaced"
    case stopped = "Stopped"
    case suspended = "Suspended"
    case expired = "Expired"
    case queued = "Queued"
    case triggered = "Triggered"
    case activated = "Activated"
    case pendingRiskReview = "PendingRiskReview"
    
}


public enum HistoricalDataGranularity: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case oneMinute = "OneMinute"
    case twoMinutes = "TwoMinutes"
    case threeMinutes = "ThreeMinutes"
    case fourMinutes = "FourMinutes"
    case fiveMinutes = "FiveMinutes"
    case tenMinutes = "TenMinutes"
    case fifteenMinutes = "FifteenMinutes"
    case twentyMinutes = "TwentyMinutes"
    
    case halfHour = "HalfHour"
    case oneHour = "OneHour"
    case twoHours = "TwoHours"
    case fourHours = "FourHours"
    
    case oneDay = "OneDay"
    case oneWeek = "OneWeek"
    case oneMonth = "OneMonth"
    case oneYear = "OneYear"
    
}


public enum OrderClass: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case primary = "Primary"
    case limit = "Limit"
    case stopLoss = "StopLoss"
    
}


public enum StrategyType: String, Codable, CaseIterable, Sendable, BitwiseCopyable {
    
    case coveredCall = "CoveredCall"
    case marriedPuts = "MarriedPuts"
    case verticalCallSpread = "VerticalCallSpread"
    case verticalPutSpread = "VerticalPutSpread"
    case calendarCallSpread = "CalendarCallSpread"
    case calendarPutSpread = "CalendarPutSpread"
    case diagonalCallSpread = "DiagonalCallSpread"
    case diagonalPutSpread = "DiagonalPutSpread"
    case collar = "Collar"
    case straddle = "Straddle"
    case strangle = "Strangle"
    case butterflyCall = "ButterflyCall"
    case butterflyPut = "ButterflyPut"
    case ironButterfly = "IronButterfly"
    case condorCall = "CondorCall"
    case custom = "Custom"
    
}

