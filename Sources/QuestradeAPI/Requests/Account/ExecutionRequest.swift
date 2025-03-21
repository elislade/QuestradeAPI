

public struct ExecutionRequest: Equatable {
    
    public var accountNumber: AccountNumber
    public var dateInterval: DateInterval
    
    public nonisolated init(accountNumber: AccountNumber, dateInterval: DateInterval = .today){
        self.accountNumber = accountNumber
        self.dateInterval = dateInterval
    }
    
    public struct Response: Equatable, Codable {
        public let executions: [Execution]
    }
    
}


extension ExecutionRequest: Requestable {

    public nonisolated var endpoint: String {
        "/v1/accounts/\(accountNumber)/executions"
    }
    
    public nonisolated var params: [String : String] {
        [
            "startTime": .formatted(questDate: dateInterval.start),
            "endTime": .formatted(questDate: dateInterval.end)
        ]
    }
    
}
