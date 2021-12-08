
import Foundation

extension API {
    
    public func serverTime(completion: @escaping Response<ServerTime>) {
        provider.request(Request("/time"), response: errorMiddleware(completion))
    }
    
    
    //MARK: - Account Requests
    
    public func accounts(completion: @escaping Response<AccountResponse>) {
        provider.request(Request("/accounts"), response: errorMiddleware(completion))
    }
    
    public func positions(for accountNumber: String, completion: @escaping Response<PositionResponse>) {
        let req = Request("/accounts/\(accountNumber)/positions")
        provider.request(req, response: errorMiddleware(completion))
    }
    
    public func balances(for accountNumber: String, completion: @escaping Response<BalanceResponse>) {
        let req = Request("/accounts/\(accountNumber)/balances")
        provider.request(req, response: errorMiddleware(completion))
    }
    
    public func orders(req: OrderRequest, completion: @escaping Response<OrderResponse>) {
        let endpoint = "/accounts/\(req.accountNumber)/orders" + queryString([
            "startTime" : dateFormatter.string(from: req.dateInterval.start),
            "endTime": dateFormatter.string(from: req.dateInterval.end),
            "stateFilter": req.stateFilter?.rawValue,
            "orderId": "\(req.orderId)"
        ])
        
        provider.request(Request(endpoint), response: errorMiddleware(completion))
    }
    
    public func postOrder(req: PostOrderRequest, completion: @escaping Response<OrderResponse>) {
        provider.request(Request(
            "/accounts/\(req.accountNumber)/orders",
            method: .POST,
            body: try? JSONEncoder.quest.encode(req)
        ), response: errorMiddleware(completion))
    }
    
    public func postOrderImpact(req: PostOrderRequest, completion: @escaping Response<OrderImpact>) {
        provider.request(Request(
            "/accounts/\(req.accountNumber)/orders/impact",
            method: .POST,
            body: try? JSONEncoder.quest.encode(req)
        ), response: errorMiddleware(completion))
    }
    
    public func activities(for accountNumber: String, completion: @escaping Response<ActivityResponse>) {
        var endpoint = "/accounts/\(accountNumber)/activities"
        
        // Maximum 31 days of data can be requested at a time.
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: now)!
        endpoint += queryString([
            "startTime" : dateFormatter.string(from: startDate),
            "endTime": dateFormatter.string(from: now),
        ])

        provider.request(Request(endpoint), response: errorMiddleware(completion))
    }
    
    public func executions(req: ExecutionRequest, completion: @escaping Response<ExecutionResponse>) {
        let endpoint = "/accounts/\(req.accountNumber)/executions" + queryString([
            "startTime": dateFormatter.string(from: req.dateInterval.start),
            "endTime": dateFormatter.string(from: req.dateInterval.end)
        ])
        
        provider.request(Request(endpoint), response: errorMiddleware(completion))
    }
    
    
    //MARK: - Market Requests
    
    public func markets(completion: @escaping Response<MarketResponse>) {
        provider.request(Request("/markets"), response: errorMiddleware(completion))
    }
    
    public func quotes(for symbolID: Int, completion: @escaping Response<QuoteResponse>) {
        provider.request(Request("/markets/quotes/\(symbolID)"), response: errorMiddleware(completion))
    }
    
    public func optionQuotes(req: OptionRequest, completion: @escaping Response<OptionQuoteResponse>) {
        provider.request(
            Request("/markets/quotes/options", method: .POST, body: try? JSONEncoder.quest.encode(req)),
            response: errorMiddleware(completion)
        )
    }
    
    public func strategies(req: StrategyVariantRequest, completion: @escaping Response<StrategyQuoteResponse>) {
        provider.request(
            Request("/markets/quotes/strategies", method: .POST, body: try? JSONEncoder.quest.encode(req)),
            response: errorMiddleware(completion)
        )
    }
    
    public func candles(req: CandleRequest, completion: @escaping Response<CandleResponse>) {
        let endpoint = "/markets/candles/\(req.symbolID)" + queryString([
            "interval" : req.granularity.rawValue,
            "startTime": dateFormatter.string(from: req.dateInterval.start),
            "endTime"  : dateFormatter.string(from: req.dateInterval.end)
        ])
        
        provider.request(Request(endpoint), response: errorMiddleware(completion))
    }
    
    
    //MARK: - Symbol Requests
    
    public func symbols(for symbolID: Int, completion: @escaping Response<SymbolResponse>) {
        provider.request(Request("/symbols/\(symbolID)"), response: errorMiddleware(completion))
    }
    
    public func options(for symbolID: Int, completion: @escaping Response<OptionResponse>) {
        provider.request(Request("/markets/symbols/\(symbolID)/options"), response: errorMiddleware(completion))
    }
    
    public func search(req: SearchRequest, completion: @escaping Response<SearchResponse>) {
        let endpoint = "/symbols/search" + queryString([
            "prefix" : req.prefix,
            "offset": "\(req.offset)",
        ])
        
        provider.request(Request(endpoint), response: errorMiddleware(completion))
    }
}
