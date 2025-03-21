import SwiftUI
import QuestradeAPI


struct RevokeAccessButton: View {
    
    @State private var revoking = false
    
    private func revoke() {
        Task {
            do {
                revoking = true
                try await Session.shared.revokeAccess()
            } catch {
                logError(error)
            }
            revoking = false
        }
    }
    
    var body: some View {
        Button(role: .destructive, action: revoke){
            if revoking {
                ProgressView()
            }
            
            Text("Revoke Access")
        }
        .disabled(revoking)
    }
    
}


#Preview {
    RevokeAccessButton()
}
