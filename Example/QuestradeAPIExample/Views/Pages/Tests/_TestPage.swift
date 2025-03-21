import SwiftUI
import QuestradeAPI


struct TestPage<FollowingContent: View>: View {
    
    let title: String
    let requests: [any Requestable]
    @ViewBuilder let followingContent: () -> FollowingContent
    
    @State private var isRunning = false
    @State private var status: [TestStatus] = []
    
    private var canRun: Bool {
        !requests.isEmpty && !isRunning
    }
    
    private func run() {
        guard canRun else { return }
        Task {
            isRunning = true
            status = Array(repeating: .waiting, count: requests.count)
            for (i, request) in requests.enumerated() {
                do {
                    status[i] = .running
                    _ = try await request.response()
                    status[i] = .succeeded
                } catch {
                    status[i] = .failed
                    logError(error)
                }
            }
            isRunning = false
        }
    }
    
    var body: some View {
        Page {
            VStack(spacing: 0) {
                ForEach(requests.indices, id: \.self){ i in
                    Cell(request: requests[i], status: status.safe(i))
                        .drawingGroup()
                    
                    if i != requests.count - 1 {
                        Divider()
                    }
                }
            }
            .background {
                GroupMaterial(RoundedRectangle(cornerRadius: 16))
            }
            
            followingContent()
        } header: {
            HeaderView(title: title, subtitle: "Request tests.")
        } footer : {
            Button(action: run){
                if isRunning {
                    Label{ Text("Running...") } icon: {
                        ProgressView()
                    }
                    .transition(.scale(scale: 0.8).combined(with: .opacity))
                } else {
                    Label("Run", systemImage: "arrow.up.circle")
                        .transition(.scale(scale: 0.8).combined(with: .opacity))
                }
            }
            .animation(.smooth, value: isRunning)
            .disabled(!canRun)
        }
        .modifier(ErrorModifier())
    }
    
    
    struct Cell: View {
        let request: any Requestable
        let status: TestStatus?
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text(request.method.rawValue.uppercased()) + Text(" \(type(of: request))")
                    
                    Spacer(minLength: 10)
                    
                    TestStatusView(status: status)
                }
                .font(.headline)
                
                Text(request.endpoint)
                    .font(.caption2)
                    .opacity(0.5)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.6)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    
}


extension TestPage where FollowingContent == EmptyView {
    
    init (
        title: String,
        requests: [any Requestable]
    ) {
        self.init(title: title, requests: requests, followingContent: { EmptyView() })
    }
    
}


#Preview {
    TestPage(
        title: "Example",
        requests: [
            ServerTimeRequest(),
            MarketsRequest()
        ]
    )
    .previewSize()
    .tint(.fakeTint)
    .onAppear {
        Session.shared.requestBuilder = .fakeData
    }
}


extension Array {
    
    func safe(_ index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
}
