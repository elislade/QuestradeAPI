import SwiftUI


struct ContentView: View {
    
    @AppStorage("useFakeData") private var useFakeData = true
    @State private var authState: AuthState = .notAuthorized
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                MainPage(authState: authState)
            }
            .modifier(ErrorModifier())
            #if os(watchOS)
            .overlay(alignment: .topLeading){
                EnvironmentToggle(isFake: $useFakeData)
                    .offset(x: 14, y: (proxy.safeAreaInsets.top - 32) / 2)
                    .ignoresSafeArea()
            }
            #else
            .safeAreaInset(edge: .top, spacing: 0){
                EnvironmentToggle(isFake: $useFakeData)
                    .padding(.top, 14)
            }
            #endif
            .tint(useFakeData ? .fakeTint : .realTint)
            .onAuthStateChange{ authState = $0 }
        }
        #if os(macOS)
        .frame(minWidth: 340)
        #endif
    }
    
}


#Preview {
    ContentView()
        .previewSize()
}


enum AuthState: Hashable, Sendable, BitwiseCopyable {
    case authorized
    case notAuthorized
    case waitingForAuthorization
}


extension View {
    
    func previewSize() -> some View {
        #if os(macOS)
        frame(width: 300, height: 500)
        #else
        self
        #endif
    }
    
}
