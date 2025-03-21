

public struct CandleRequest: Equatable, Codable, Sendable {
    
    public var symbolID: Int
    public var dateInterval: DateInterval
    public var granularity: HistoricalDataGranularity
    
    public nonisolated init(
        symbolID: Int,
        dateInterval: DateInterval,
        granularity: HistoricalDataGranularity
    ) {
        self.symbolID = symbolID
        self.dateInterval = dateInterval
        self.granularity = granularity
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let candles: [Candle]
    }
    
}


extension CandleRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/markets/candles/\(symbolID)"
    }
    
    public nonisolated var params: [String : String] {
        [
            "interval" : granularity.rawValue,
            "startTime": .formatted(questDate: dateInterval.start),
            "endTime"  : .formatted(questDate: dateInterval.end)
        ]
    }
    
}
