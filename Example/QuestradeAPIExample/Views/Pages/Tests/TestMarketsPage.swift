import SwiftUI
import QuestradeAPI


struct TestMarketsPage: View {
    
    var body: some View {
        TestPage(title: "Markets", requests: [
            MarketsRequest(),
            QuotesRequest(symbolId: 8049),
            CandleRequest(
                symbolID: 8049,
                dateInterval: .today,
                granularity: .fiveMinutes
            ),
            OptionQuoteRequest(
                filters: [
                    .init(
                        optionType: .call,
                        underlyingId: 8049,
                        expiryDate: Date(timeIntervalSinceNow: 24 * 60 * 60 * 30)
                    )
                ],
                optionIds: []
            ),
            StrategyQuoteRequest(
                variants: [
                    .init(
                        variantId: 1,
                        strategy: .custom,
                        legs: [
                            .init(symbolId: 8049, action: .buy, ratio: 1000),
                            .init(symbolId: 9291, action: .sell, ratio: 10)
                        ]
                    )
                ]
            )
        ])
    }
    
}


#Preview {
    TestMarketsPage()
        .previewSize()
}
