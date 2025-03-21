import SwiftUI


struct AuthorizeAccessButton: View {
    
    @Environment(\.openURL) private var openURL
    
    let isAuthorizing: Bool
    
    var body: some View {
        Button{ openURL(.authURL) } label: {
            if isAuthorizing {
                ProgressView()
                Text("Authenticating...")
            } else {
                Text("Authenticate")
            }
        }
        .disabled(isAuthorizing)
    }
    
}


#Preview {
    AuthorizeAccessButton(isAuthorizing: true)
    AuthorizeAccessButton(isAuthorizing: false)
}
