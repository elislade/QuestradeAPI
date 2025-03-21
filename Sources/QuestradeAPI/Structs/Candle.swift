

public struct Candle: Equatable, Codable, Sendable {
    
    public let start: Date
    public let end: Date
    public let open: Double
    public let high: Double
    public let low: Double
    public let close: Double
    public let volume: Int
    
    public nonisolated init(
        start: Date,
        end: Date,
        open: Double,
        high: Double,
        low: Double,
        close: Double,
        volume: Int
    ) {
        self.start = start
        self.end = end
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
    }
    
}
