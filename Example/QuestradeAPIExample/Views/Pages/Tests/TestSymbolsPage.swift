import SwiftUI
import QuestradeAPI


struct TestSymbolsPage: View {
    
    var body: some View {
        TestPage(title: "Symbols", requests: [
            SymbolSearchRequest(term: "Apple"),
            SymbolsRequest(symbolIds: [8049]),
            SymbolOptionChainRequest(symbolID: 9291)
        ])
    }
    
}


#Preview {
    TestSymbolsPage()
        .previewSize()
}
