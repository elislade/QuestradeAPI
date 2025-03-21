import SwiftUI
import QuestradeAPI


struct MainPage: View {
    
    var authState: AuthState = .notAuthorized
    
    var body: some View {
        Page {
            if authState == .authorized {
                AuthorizedView()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        } header: {
            HeaderView(
                title: "Questrade API",
                subtitle: "Example usage."
            )
        } footer: {
            AuthStateActions(state: authState)
        }
        .animation(.smooth, value: authState)
    }
    
}


#Preview {
    MainPage()
        .previewSize()
}
