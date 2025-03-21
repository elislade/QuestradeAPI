

public struct Account: Equatable, Codable, Identifiable, Sendable {
    
    public nonisolated var id: AccountNumber { number }
    
    public let type: AccountType
    public let number: AccountNumber
    public let status: AccountStatus
    public let isPrimary: Bool
    public let isBilling: Bool
    public let clientAccountType: ClientAccountType
    
    public nonisolated init(
        type: AccountType,
        number: AccountNumber,
        status: AccountStatus,
        isPrimary: Bool,
        isBilling: Bool,
        clientAccountType: ClientAccountType
    ) {
        self.type = type
        self.number = number
        self.status = status
        self.isPrimary = isPrimary
        self.isBilling = isBilling
        self.clientAccountType = clientAccountType
    }
    
}
