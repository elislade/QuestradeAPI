import SwiftUI
import QuestradeAPI

struct ErrorsListView: View {
    
    let ns: Namespace.ID
    let errors: [LoggedError]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                ForEach(errors.reversed()) { error in
                    let i = Double(errors.firstIndex(where: { $0.id == error.id })!)
                        ZStack {
                            ErrorView(error: error)
                        }
                        #if os(tvOS)
                        .focusable()
                        #endif
                        .zIndex(i)
                        .matchedGeometryEffect(id: error.id, in: ns)
                        .transition(.offset(y: -170))
                }
            }
            .padding()
            .frame(maxWidth: .maxNotificationWidth)
            .frame(maxWidth: .infinity)
            .animation(.smooth, value: errors.count)
        }
        .disableScrollClip()
    }
    
}


extension View {
    
    @ViewBuilder func disableScrollClip() -> some View {
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            scrollClipDisabled(true)
        } else {
            self
        }
    }
    
}


#Preview {
    ErrorsListView(
        ns: Namespace().wrappedValue,
        errors: [
            .init(TestError()),
            .init(TestError()),
            .init(TestError()),
            .init(TestError())
        ]
    )
    .previewSize()
    .tint(.fakeTint)
}
