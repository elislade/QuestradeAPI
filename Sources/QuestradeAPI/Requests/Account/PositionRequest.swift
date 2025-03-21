

public struct PositionRequest: Equatable, Codable {
    
    public var accountNumber: AccountNumber
    
    public nonisolated init(accountNumber: AccountNumber) {
        self.accountNumber = accountNumber
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let positions: [Position]
    }
    
}


extension PositionRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/accounts/\(accountNumber)/positions"
    }
    
}
