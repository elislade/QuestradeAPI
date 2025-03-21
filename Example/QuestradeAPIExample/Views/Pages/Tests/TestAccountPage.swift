import SwiftUI
import QuestradeAPI


struct TestAccountPage: View {
    
    let accountNumber: AccountNumber
    
    var body: some View {
        TestPage(
            title: "Account \(accountNumber)",
            requests: [
                PositionRequest(accountNumber: accountNumber),
                BalancesRequest(accountNumber: accountNumber),
                ActivitiesRequest(accountNumber: accountNumber),
                ExecutionRequest(accountNumber: accountNumber, dateInterval: .tillNow),
                OrderRequest(accountNumber: accountNumber, dateInterval: .tillNow)
            ]
        )
    }
    
}


#Preview {
    TestAccountPage(accountNumber: "40044450")
        .previewSize()
}
