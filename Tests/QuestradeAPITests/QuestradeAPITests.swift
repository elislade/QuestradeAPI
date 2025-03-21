import Testing
import QuestradeAPI
import QuestradeAPIFakes
import stdlib_h

func env(_ key: String, fallback: String) -> String {
    if let value = getenv(key) {
        String(utf8String: value) ?? fallback
    } else {
        fallback
    }
}


struct AuthTests {
    
    init() {
        Session.shared.requestBuilder = .fakeData
    }
    
    @Test func tokenRefresh() async throws {
        let request = RefreshAccessRequest(refreshToken: "")
        let response = try await request()
        assert(!response.accessToken.isEmpty)
    }
    
    @Test func revokeAccess() async throws {
        let request = RevokeAccessRequest()
        _ = try await request()
    }
    
}


struct RootTests {
    
    init() {
        Session.shared.requestBuilder = .fakeData
    }
    
    @Test func serverTime() async throws {
        let request = ServerTimeRequest()
        let response = try await request()
        assert(response.time.timeIntervalSince1970 > 0)
    }
    
}


struct AccountTests {
    
    let accountNumber: AccountNumber
    
    init() {
        self.accountNumber = AccountNumber(env("QUEST_ACCOUNT_NUMBER", fallback: "12345678"))
        Session.shared.requestBuilder = .fakeData
    }
    
    @Test func accounts() async throws {
        let response = try await AccountsRequest()()
        assert(response.accounts.isEmpty == false)
    }
    
    @Test func activities() async throws {
        let response = try await ActivitiesRequest(accountNumber: accountNumber)()
        assert(response.activities.isEmpty == false)
    }
    
    @Test func executions() async throws {
        let response = try await ExecutionRequest(accountNumber: accountNumber, dateInterval: .today)()
        assert(response.executions.isEmpty == false)
    }
    
    @Test func positions() async throws {
        let res = try await PositionRequest(accountNumber: accountNumber)()
        assert(res.positions.isEmpty == false)
    }
    
    @Test func balances() async throws {
        let request = BalancesRequest(accountNumber: accountNumber)
        let response = try await request()
        assert(response.combinedBalances.isEmpty == false)
    }
    
    @Test func orders() async throws {
        let request = OrderRequest(accountNumber: accountNumber)
        let response = try await request()
        assert(response.orders.isEmpty == false)
    }
    
}


struct MarketTests {
    
    init() {
        Session.shared.requestBuilder = .fakeData
    }
    
    @Test func markets() async throws {
        let request = MarketsRequest()
        let response = try await request()
        assert(response.markets.isEmpty == false)
    }
    
    @Test func quotes() async throws {
        let request = QuotesRequest(symbolId: 6)
        let response = try await request()
        assert(!response.quotes.isEmpty)
    }
    
    @Test func candles() async throws {
        let request = CandleRequest(
            symbolID: 404,
            dateInterval: .last30Days,
            granularity: .oneHour
        )
        let response = try await request()
        assert(response.candles.isEmpty == false)
    }
    
}


struct SymbolTests {
    
    init() {
        Session.shared.requestBuilder = .fakeData
    }
    
    @Test func symbolSearch() async throws {
        let request = SymbolSearchRequest(term: "APPL")
        let response = try await request()
        assert(response.symbols.isEmpty == false)
    }
    
    @Test func symbols() async throws {
        let request = SymbolsRequest(symbolId: 0)
        let response = try await request()
        assert(response.symbols.isEmpty == false)
    }
    
    @Test func symbolOptionChain() async throws {
        let request = SymbolOptionChainRequest(symbolID: 0)
        let response = try await request()
        assert(response.optionChain.isEmpty == false)
    }
    
}
