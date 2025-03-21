import SwiftUI


struct AuthStateActions: View {
    
    let state: AuthState
    
    var body: some View {
        if state == .authorized {
            RevokeAccessButton()
                .transition(.opacity.combined(with: .scale).animation(.smooth))
        } else {
            AuthorizeAccessButton(isAuthorizing: state == .waitingForAuthorization)
                .transition(.opacity.combined(with: .scale).animation(.smooth))
        }
    }
    
}

#Preview("Authorized") {
    AuthStateActions(state: .authorized)
        .padding()
        .previewSize()
}

#Preview("Not Authorized") {
    AuthStateActions(state: .notAuthorized)
        .padding()
        .previewSize()
}

#Preview("Waiting For Authorization") {
    AuthStateActions(state: .waitingForAuthorization)
        .padding()
        .previewSize()
}
