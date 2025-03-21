

public struct Market: Equatable, Codable, Sendable {
    
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
    public let snapQuotesLimit: Int
    
    public nonisolated init(
        name: String,
        tradingVenues: [String],
        defaultTradingVenue: String,
        primaryOrderRoutes: [String],
        secondaryOrderRoutes: [String],
        level1Feeds: [String],
        level2Feeds: [String],
        extendedStartTime: Date,
        startTime: Date,
        endTime: Date,
        snapQuotesLimit: Int
    ) {
        self.name = name
        self.tradingVenues = tradingVenues
        self.defaultTradingVenue = defaultTradingVenue
        self.primaryOrderRoutes = primaryOrderRoutes
        self.secondaryOrderRoutes = secondaryOrderRoutes
        self.level1Feeds = level1Feeds
        self.level2Feeds = level2Feeds
        self.extendedStartTime = extendedStartTime
        self.startTime = startTime
        self.endTime = endTime
        self.snapQuotesLimit = snapQuotesLimit
    }
    
}
