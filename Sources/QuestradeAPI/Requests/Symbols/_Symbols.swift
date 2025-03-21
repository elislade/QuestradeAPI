

extension EquitySymbol: SymbolQuotable { }
extension Symbol: SymbolQuotable, SymbolOptionalable { }


public protocol SymbolIdAssociable {
    var symbolId: Int { get }
}

public protocol SymbolQuotable: SymbolIdAssociable {
    var isQuotable: Bool { get }
}

public extension SymbolQuotable {
    
    var isQuotable: Bool { true }
    
    nonisolated func quote() async throws -> Quote {
        guard isQuotable else { throw SymbolQuoteError.symbolNotQuotable }
        let response = try await QuotesRequest(symbolId: symbolId).response()
        guard let quote = response.quotes.first else { throw SymbolQuoteError.quoteNotFound }
        return quote
    }
    
}

enum SymbolQuoteError: Error {
    case symbolNotQuotable
    case quoteNotFound
}

public protocol SymbolOptionalable: SymbolIdAssociable  {
    
    var hasOptions: Bool { get }
    
}


extension SymbolOptionalable {
    
    nonisolated func optionChain() async throws -> [OptionChainElement] {
        guard hasOptions else { throw SymbolOptionError.symbolHasNoOptions }
        return try await SymbolOptionChainRequest(symbolID: symbolId).response().optionChain
    }
    
}


enum SymbolOptionError: Error {
    case symbolHasNoOptions
}
