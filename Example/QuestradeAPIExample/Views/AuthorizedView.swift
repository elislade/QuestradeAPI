import SwiftUI
import QuestradeAPI


struct AuthorizedView: View {
    
    var body: some View {
        Accounts()
        
        HStack {
            Markets()
            Symbols()
        }
        .transition(.scale(scale: 0.5).combined(with: .opacity))
        
        ServerTime()
            .transition(.scale(scale: 0.5).combined(with: .opacity))
        
        Streaming()
            .transition(.scale(scale: 0.5).combined(with: .opacity))
    }
    
    
    struct Accounts: View {
        
        @State private var response: AccountsRequest.Response?
        @State private var fetching = false
        
        private func fetch() {
            Task {
                fetching = true
                let request = AccountsRequest()
                do {
                    let response = try await request()
                    withAnimation(.smooth){
                        self.response = response
                    }
                } catch {
                    logError(error)
                }
                fetching = false
            }
        }
        
        var body: some View {
            if let response, response.accounts.isEmpty == false {
                Group {
                    HStack(spacing: 2) {
                        Text("Accounts".uppercased())
                        
                        Spacer()
                        
                        Image(systemName: "person.fill")
                        
                        Text("\(response.userId)")
                            .opacity(0.6)
                    }
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
                    .font(.caption.bold())
                    .lineLimit(1)
                    
                    ForEach(response.accounts){ account in
                        Cell(account: account)
                    }
                }
                .transition(.scale(scale: 0.5).combined(with: .opacity))
            } else {
                Button(action: fetch){
                    if fetching {
                        ProgressView()
                    }
                    
                    Text("Accounts")
                }
                .disabled(fetching)
                .animation(.smooth, value: fetching)
                .transition(.scale(scale: 0.5).combined(with: .opacity))
            }
        }
        
        
        struct Cell: View {
            
            let account: Account

            @State private var fetching = false
            
            private func fetch() {
                fetching = true
            }
            
            var body: some View {
                Button(action: fetch){
                    Text(account.type.rawValue)
                        .font(.body.bold())
                    
                    Spacer(minLength: 0)
                    
                    Text("\(account.number)")
                    
                    if fetching {
                        ProgressView()
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        Image(systemName: "chevron.right")
                            .font(.body.weight(.heavy))
                            .opacity(0.2)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .disabled(fetching)
                .animation(.smooth, value: fetching)
                .present(isPresented: $fetching){
                    TestAccountPage(accountNumber: account.number)
                }
            }
        }
        
    }
    
    
    struct Streaming: View {
        
        @State private var fetching = false
        
        private func fetch() {
            fetching = true
        }
        
        var body: some View {
            Button(action: fetch){
                if fetching {
                    ProgressView()
                }

                Text("Streaming")
            }
            .disabled(fetching)
            .present(isPresented: $fetching){
                TestStreamingPage()
            }
        }
        
    }
    
    
    struct ServerTime: View {
        
        @State private var time: Date?
        @State private var fetching = false
        
        private func fetch() {
            Task {
                withAnimation(.smooth){
                    fetching = true
                }
                do {
                    let response = try await ServerTimeRequest().response()
                    withAnimation(.smooth){
                        self.time = response.time
                        fetching = false
                    }
                } catch {
                    logError(error)
                }
                withAnimation(.smooth){
                    fetching = false
                }
            }
        }
        
        var body: some View {
            Button(action: fetch){
                if fetching {
                    ProgressView()
                }
                
                VStack {
                    Text("Server Time")
                    
                    if let time, !fetching {
                        Text(time, format: .dateTime.month().day().hour().minute().second())
                            .font(.caption)
                            .opacity(0.5)
                            .transition(.scale)
                    }
                }
            }
            .disabled(fetching)
        }
        
    }
    
    
    struct Markets: View {
        
        @State private var fetching = false
        
        private func fetch() {
            fetching = true
        }
        
        var body: some View {
            Button(action: fetch){
                if fetching {
                    ProgressView()
                }
                
                Text("Markets")
            }
            .disabled(fetching)
            .animation(.smooth, value: fetching)
            .present(isPresented: $fetching){
                TestMarketsPage()
            }
        }
        
    }
    
    
    struct Symbols: View {
        
        @State private var fetching = false
        
        private func fetch() {
            fetching = true
        }
        
        var body: some View {
            Button(action: fetch){
                if fetching {
                    ProgressView()
                }
                
                Text("Symbols")
            }
            .disabled(fetching)
            .animation(.smooth, value: fetching)
            .present(isPresented: $fetching){
                TestSymbolsPage()
            }
        }
    }
    
}


#if canImport(QuestradeAPIFakes)

import QuestradeAPIFakes

#Preview {
    VStack {
        AuthorizedView()
    }
    .padding()
    .buttonStyle(ButtonStyle())
    .previewSize()
    .onAppear {
        Session.shared.requestBuilder = .fakeData
    }
}

#endif
