

public struct EquitySymbol: Codable, Equatable, Identifiable, Sendable {
    
    public nonisolated var id: Int { symbolId }
    
    public let symbol: String
    public let symbolId: Int
    public let description: String
    public let securityType: Security
    public let listingExchange: ListingExchange
    public let isQuotable: Bool
    public let isTradable: Bool
    public let currency: Currency
    
    public nonisolated init(
        symbol: String,
        symbolId: Int,
        description: String,
        securityType: Security,
        listingExchange: ListingExchange,
        isQuotable: Bool,
        isTradable: Bool,
        currency: Currency
    ) {
        self.symbol = symbol
        self.symbolId = symbolId
        self.description = description
        self.securityType = securityType
        self.listingExchange = listingExchange
        self.isQuotable = isQuotable
        self.isTradable = isTradable
        self.currency = currency
    }
    
}
