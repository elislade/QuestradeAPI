import XCTest
@testable import QuestradeAPI

final class QuestradeAPITests: XCTestCase {
    
    class Storage: Storable {
        private var data: Data = Data()
        
        func get() -> Data { data }
        func set(_ newValue: Data) { data = newValue }
        func delete() { data = Data() }
    }
    
    var accountNumber = ""
    
    func api(fake: Bool = false) -> API {
        if fake {
            return API()
        } else {
            return API(provider: AuthProvider(tokenStore: Storage()))
        }
    }
    
    func testServerTime() throws {
        api().serverTime{ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testAccounts() throws {
        api().accounts{ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testPositions() throws {
        api().positions(for: accountNumber){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testBalances() throws {
        api().balances(for: accountNumber){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testOrders() throws {
        let req = OrderRequest(
            accountNumber: accountNumber,
            dateInterval: .init(start: Date(), end: Date()),
            stateFilter: .Activated,
            orderId: 0
        )
        
        api().orders(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testPostOrder() throws {
        let req = PostOrderRequest()
        
        api().postOrder(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testPostOrderImpact() throws {
        let req = PostOrderRequest()
        
        api().postOrderImpact(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testActivities() throws {
        api().activities(for: accountNumber){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testExecutions() throws {
        let req = ExecutionRequest(
            accountNumber: 045,
            dateInterval: .init(start: Date(), end: Date())
        )
        
        api().executions(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testMarkets() throws {
        api().markets{ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testQuotes() throws {
        api().quotes(for: 0){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testOptionQuotes() throws {
        let req = OptionRequest(
            filters: [],
            optionIds: [0]
        )
        
        api().optionQuotes(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testStrategies() throws {
        let req = StrategyVariantRequest(variants: [
            StrategyVariant(
                variantId: 0,
                strategy: .ButterflyCall,
                legs: [ Leg(symbolId: 0, action: .Buy, ratio: 2) ]
            )
        ])
        
        api().strategies(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testCandles() throws {
        let req = CandleRequest(
            symbolID: 0,
            dateInterval: .init(start: Date(), duration: 1000),
            granularity: .FifteenMinutes
        )
        
        api().candles(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testSymbols() throws {
        api().symbols(for: 0){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testOptions() throws {
        api().options(for: 0){ res in
            XCTAssertNoThrow(res.get)
        }
    }
    
    func testSearch() throws {
        let req = SearchRequest(prefix: "", offset: 0)
        
        api().search(req: req){ res in
            XCTAssertNoThrow(res.get)
        }
    }
}
