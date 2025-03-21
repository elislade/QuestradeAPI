

public extension SymbolIdAssociable {
    
    func candles(
        dateInterval: DateInterval = .today,
        granularity: HistoricalDataGranularity = .twentyMinutes
    ) async throws -> [Candle] {
        try await CandleRequest(
            symbolID: symbolId,
            dateInterval: dateInterval,
            granularity: granularity
        ).response().candles
    }
    
}
