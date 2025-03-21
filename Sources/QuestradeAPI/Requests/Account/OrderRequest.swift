

public struct OrderRequest: Equatable, Codable {
    
    public var accountNumber: AccountNumber
    public var dateInterval: DateInterval
    public var stateFilter: StateFilter
    public var orderIds: Set<Int>
    
    public enum StateFilter: String, Codable, Sendable, BitwiseCopyable {
        
        case all = "All"
        case opened = "Opened"
        case closed = "Closed"
        
    }
    
    public nonisolated init(
        accountNumber: AccountNumber,
        dateInterval: DateInterval = .today,
        stateFilter: StateFilter = .all,
        orderIds: Set<Int> = []
    ) {
        self.accountNumber = accountNumber
        self.dateInterval = dateInterval
        self.stateFilter = stateFilter
        self.orderIds = orderIds
    }
    
    public struct Response: Equatable, Codable {
        public let orders: [Order]
    }
    
}


extension OrderRequest: Requestable {
    
    public nonisolated var endpoint: String {
        let orderIds = orderIds.sorted()
        let base = "/v1/accounts/\(accountNumber)/orders"
        let orderBase = orderIds.isEmpty ? base : orderIds.count == 1 ? base + "/\(orderIds[0])" : base
        return orderBase
    }
    
    public nonisolated var params: [String : String] {
        var result: [String : String] = [
            "stateFilter" : stateFilter.rawValue,
            "startTime" : .formatted(questDate: dateInterval.start),
            "endTime": .formatted(questDate:  dateInterval.end)
        ]
        
        if orderIds.count > 1 {
            result["ids"] = orderIds.map{ String($0) }.joined(separator: ",")
        }
        
        return result
    }
    
}
