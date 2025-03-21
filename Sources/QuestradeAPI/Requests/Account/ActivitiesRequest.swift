

public struct ActivitiesRequest: Equatable, Codable {
    
    public var accountNumber: AccountNumber
    public var dateInterval: DateInterval
    
    public nonisolated init(
        accountNumber: AccountNumber,
        dateInterval: DateInterval = .last30Days
    ) {
        self.dateInterval = dateInterval
        self.accountNumber = accountNumber
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let activities: [Activity]
    }

}


extension ActivitiesRequest: Requestable {
    
    public nonisolated var endpoint: String {
        "/v1/accounts/\(accountNumber)/activities"
    }
    
    public nonisolated var params: [String : String] {
        [
            "startTime" : .formatted(questDate: dateInterval.start),
            "endTime" : .formatted(questDate: dateInterval.end)
        ]
    }
    
}
