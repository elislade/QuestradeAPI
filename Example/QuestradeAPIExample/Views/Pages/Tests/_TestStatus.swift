import SwiftUI


enum TestStatus: CaseIterable, Sendable, BitwiseCopyable {
    case waiting
    case running
    case succeeded
    case failed
    
    nonisolated var isCompleted: Bool {
        self == .failed || self == .succeeded
    }
}

struct TestStatusView: View {
    
    let status: TestStatus?
    
    var body: some View {
        ZStack {
            if let status {
                Group {
                    switch status {
                    case .running:
                        ProgressView()
                    case .succeeded:
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    case .failed:
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                    case .waiting:
                        Image(systemName: "clock.fill")
                            .foregroundStyle(.secondary)
                    }
                }
                .transition(.scale)
            } else {
                Image(systemName: "clock.fill")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 22, height: 22)
        .font(.body.weight(.bold))
        .animation(.smooth, value: status)
    }
}


#Preview {
    HStack {
        ForEach(TestStatus.allCases, id: \.self){
            TestStatusView(status: $0)
        }
    }
    .progressViewStyle(ProgressStyle())
    .previewSize()
    .tint(.pink)
}
