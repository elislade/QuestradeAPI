

public extension Account {
    
    nonisolated func activities() async throws -> [Activity] {
        try await ActivitiesRequest(accountNumber: number).response().activities
    }
    
    nonisolated func balances() async throws -> BalancesRequest.Response {
        try await BalancesRequest(accountNumber: number).response()
    }
    
    nonisolated func positions() async throws -> [Position] {
        try await PositionRequest(accountNumber: number).response().positions
    }
    
    nonisolated func executions(in interval: DateInterval = .today) async throws -> [Execution] {
        let request = ExecutionRequest(accountNumber: number, dateInterval: interval)
        return try await request().executions
    }
    
    nonisolated func orders(
        dateInterval: DateInterval = .today,
        stateFilter: OrderRequest.StateFilter = .all,
        orderIds: Set<Int> = []
    ) async throws -> [Order] {
        let request = OrderRequest(accountNumber: number, stateFilter: stateFilter)
        return try await request().orders
    }
    
}


// MARK: Notifications


public struct NotificationsRequest {
  
    public nonisolated init() {}
    
}


extension NotificationsRequest: StreamRequestable {
    
    public nonisolated var endpoint: String { "/v1/notifications" }
    
    public struct Response: Equatable, Codable, Sendable {
        public let accountNumber: AccountNumber
        public let orders: [Order]
        public let executions: [Execution]?
    }
    
}
