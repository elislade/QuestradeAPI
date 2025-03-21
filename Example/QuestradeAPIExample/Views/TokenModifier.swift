import SwiftUI
import QuestradeAPI
import QuestradeAPIFakes

struct TokenModifier: ViewModifier {
    
    @Environment(\.openURL) private var openURL
    
    // Don't store tokens in UserDefaults for production.
    // This is only here for ease-of-use in example.
    @AppStorage("sessionToken") private var persistedToken: Data?
    @AppStorage("useFakeData") private var useFakeData = true
    @StateObject private var session = Session.shared
    @State private var state: AuthState = .notAuthorized
    
    let action: (AuthState) -> Void
    
    private func load(persistedToken: Data) {
        if
            let token = try? JSONDecoder().decode(AuthToken.self, from: persistedToken)
        {
            session.token = token
        }
    }
    
    private func handle(url: URL) {
        if let token = AuthResponse(oauthURL: url) {
            session.token = .init(token)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if useFakeData {
                    session.requestBuilder = .fakeData
                    state = .authorized
                    return
                }
                
                if session.token != nil {
                    state = .authorized
                }
                
                if let persistedToken {
                    load(persistedToken: persistedToken)
                }
            }
            .onOpenURL { handle(url: $0) }
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb){ activity in
                if let url = activity.webpageURL {
                    handle(url: url)
                }
            }
            #if !os(watchOS) && !os(tvOS)
            .handlesExternalEvents(preferring: [], allowing: ["*"])
            #endif
            .environment(\.openURL, OpenURLAction{ url in
                if url == .authURL {
                    state = .waitingForAuthorization
                    
                    if useFakeData {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                            state = .authorized
                            session.requestBuilder = .fakeData
                        }
                        return .handled
                    } else if let persistedToken {
                        load(persistedToken: persistedToken)
                        state = .authorized
                        return .discarded
                    } else {
                        return .systemAction
                    }
                } else {
                    return .systemAction
                }
            })
            .onChange(of: session.token){ token in
                state = token != nil ? .authorized : .notAuthorized
                guard !useFakeData else { return }
                if let token, let data = try? JSONEncoder().encode(token) {
                    persistedToken = data
                } else {
                    persistedToken = nil
                }
            }
            .onChange(of: state, perform: action)
            .onChange(of: useFakeData){ useFakeData in
                state = .notAuthorized
                session.clear()
                
                if useFakeData {
                    session.requestBuilder = .fakeData
                }
            }
    }
    
}


extension View {
    
    func onAuthStateChange(perform action: @escaping (AuthState) -> Void) -> some View {
        modifier(TokenModifier(action: action))
    }
    
}
