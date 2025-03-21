import SwiftUI
import QuestradeAPI

struct ErrorsStackView: View {
    
    let ns: Namespace.ID
    let errors: [LoggedError]
    
    var body: some View {
        ZStack(alignment: .top) {
            ForEach(errors){ error in
                let i = Double(errors.firstIndex(where: { $0.id == error.id })!)
                let ii = Double(errors.count) - i - 1
                ErrorView(error: error)
                    .compositingGroup()
                    .opacity(1 - (ii / 5))
                    .scaleEffect(1 - min(pow(ii, 1.1) / 20, 1), anchor: .top)
                    .matchedGeometryEffect(id: error.id, in: ns)
                    .alignmentGuide(.top){ d in
                        min(ii, 2) * -8
                    }
                    .transition(.offset(y: -270))
            }
        }
        .padding()
        #if os(tvOS)
        .focusable(false)
        #endif
        .drawingGroup()
        .frame(maxWidth: .maxNotificationWidth)
        .frame(maxWidth: .infinity)
    }
    
}


#Preview {
    ErrorsStackView(
        ns: Namespace().wrappedValue,
        errors: [
            .init(TestError()),
            .init(TestError()),
            .init(TestError()),
            .init(TestError())
        ]
    )
    .previewSize()
    .tint(.realTint)
}
