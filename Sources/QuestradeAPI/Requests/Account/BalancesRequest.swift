

public struct BalancesRequest: Equatable, Codable {
    
    public var accountNumber: AccountNumber
    
    public nonisolated init(accountNumber: AccountNumber) {
        self.accountNumber = accountNumber
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let perCurrencyBalances: [Balance]
        public let combinedBalances: [Balance]
        
        // start of day
        public let sodPerCurrencyBalances: [Balance]
        public let sodCombinedBalances: [Balance]
    }
    
}


extension BalancesRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/accounts/\(accountNumber)/balances"
    }
    
}
