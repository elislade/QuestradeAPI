import SwiftUI
import QuestradeAPI


struct TestStreamingPage: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var lastUpdatedStreamDate: Date?
    @State private var streamingTasks: [String : Task<Void, Error>] = [:]
    @State private var backgroundedTasks = false
    
    @State private var quotes: QuotesRequest.Response?
    @State private var notification: NotificationsRequest.Response?
    
    private var subtitle: String? {
        guard let lastUpdatedStreamDate else {
            return nil
        }
        
        return lastUpdatedStreamDate.formatted(date: .abbreviated, time: .complete)
    }
    
    private func stream() {
        if streamingTasks.isEmpty {
            streamingTasks["Quotes"] = streamQuotes()
            streamingTasks["Notifications"] = streamNotifications()
        } else {
            stopStreaming()
        }
    }
    
    private func stopStreaming() {
        lastUpdatedStreamDate = nil
        for streamingTask in streamingTasks.values {
            streamingTask.cancel()
        }
        self.streamingTasks = [:]
    }
    
    private func streamQuotes() -> Task<Void, Error> {
        Task {
            let request = QuotesRequest(symbolId: 8049)

            do {
                for try await newQuotes in request.stream {
                    quotes = newQuotes
                    lastUpdatedStreamDate = Date()
                }
            } catch {
                logError(error)
            }
            streamingTasks["Quotes"]?.cancel()
            streamingTasks.removeValue(forKey: "Quotes")
        }
    }
    
    private func streamNotifications() -> Task<Void, Error> {
        Task {
            let request = NotificationsRequest()

            do {
                for try await newNotification in request.stream {
                    notification = newNotification
                    lastUpdatedStreamDate = Date()
                }
            } catch {
                logError(error)
            }
            streamingTasks["Notifications"]?.cancel()
            streamingTasks.removeValue(forKey: "Notifications")
        }
    }
    
    var body: some View {
       Page {
           VStack(alignment: .leading, spacing: 2) {
               Text("Market Quotes")
                   .font(.headline.bold())
                   .padding(.leading)
               
               ZStack {
                   if let quotes, let quote = quotes.quotes.first {
                       HStack {
                           Text(quote.symbol)
                               .font(.headline)
                           
                           Spacer()
                           
                           VStack(alignment: .leading) {
                               Text("VOLUME").font(.caption).opacity(0.5)
                               Text(quote.volume, format: .number)
                                   .monospacedDigit()
                           }
                           
                           PriceChangeView(
                                label: "ASK",
                                from: quote.openPrice,
                                to: quote.askPrice ?? 0
                           )
                           
                           PriceChangeView(
                                label: "BID",
                                from: quote.openPrice,
                                to: quote.bidPrice ?? 0
                           )
                       }
                       .padding(.horizontal)
                       .padding(.vertical, 10)
                       .transition(.scale)
                   } else {
                       Text("No Quotes")
                           .padding()
                           .opacity(0.5)
                   }
               }
               .minimumScaleFactor(0.8)
               .lineLimit(1)
               .frame(maxWidth: .infinity)
               .background(GroupMaterial(RoundedRectangle(cornerRadius: 12)))
           }
           
           VStack(alignment: .leading, spacing: 2) {
               
               Text("Account Notifications")
                   .font(.headline.bold())
                   .padding(.leading)
               
               ZStack {
                   if let notification {
                       VStack {
                           Text(notification.accountNumber.description)
                               .font(.headline)
                           
                           HStack {
                               VStack {
                                   Text("Orders").font(.caption).opacity(0.5)
                                   Text(notification.orders.count.description)
                                       .font(.body.monospacedDigit())
                               }
                               
                               if let executions = notification.executions {
                                   VStack {
                                       Text("Executions").font(.caption).opacity(0.5)
                                       Text(executions.count.description)
                                           .font(.body.monospacedDigit())
                                   }
                               }
                           }
                       }
                       .padding(.horizontal)
                       .padding(.vertical, 10)
                       .transition(.scale)
                   } else {
                       Text("No Notifications")
                           .padding()
                           .opacity(0.5)
                   }
               }
               .frame(maxWidth: .infinity)
               .background(GroupMaterial(RoundedRectangle(cornerRadius: 12)))
           }
        } header: {
            HeaderView(title: "Streaming", subtitle: subtitle)
        } footer: {
            Button(action: stream){
                if !streamingTasks.isEmpty {
                    ProgressView()
                }
                
                Text("Stream")
            }
        }
        .modifier(ErrorModifier())
        .animation(.smooth, value: quotes == nil)
        .animation(.smooth, value: notification == nil)
        .onDisappear(perform: stopStreaming)
        .onChange(of: scenePhase){ phase in
            switch phase {
            case .background:
                if !streamingTasks.isEmpty {
                    backgroundedTasks = true
                    stopStreaming()
                }
            case .inactive:
                SocketManager.Signal.suspendAll.send()
            case .active:
                if backgroundedTasks {
                    stream()
                    backgroundedTasks = false
                } else {
                    SocketManager.Signal.resumeAll.send()
                }
            @unknown default:
                return
            }
        }
    }
    
}


#Preview {
    TestStreamingPage()
        .previewSize()
        .tint(.fakeTint)
}


struct PriceChangeView: View {
    
    let label: String
    let from: Double
    let to: Double
    
    @Environment(\.locale) private var locale
    @AppStorage("usePercentValues") private var usePercentageChange: Bool = false
    
    private var change: Double {
        usePercentageChange ? (to - from) / from : to - from
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 2) {
                Text(label)
                    .font(.caption)
                    .opacity(0.5)

                Group {
                    if usePercentageChange {
                        Text(change, format: .percent.rounded(increment: 0.01))
                    } else {
                        Text(change, format: .currency(code: locale.currencyCode ?? "USD"))
                    }
                }
                .foregroundStyle(change >= 0 ? .green : .red)
            }
            .font(.caption)
            
            Text(to, format: .currency(code: locale.currencyCode ?? "USD"))
                .font(.body)
        }
        .monospacedDigit()
        .contentShape(Rectangle())
        .onTapGesture {
            usePercentageChange.toggle()
        }
    }
}
