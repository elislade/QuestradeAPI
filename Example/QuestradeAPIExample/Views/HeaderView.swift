import SwiftUI

struct HeaderView: View {
    
    let title: String
    var subtitle: String?
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            
            VStack {
                Text(title)
                    .font(.largeTitle.bold())
                    .lineLimit(1)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.footnote)
                        .opacity(0.5)
                }
            }
            
            Spacer(minLength: 0)
            Spacer(minLength: 0)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .multilineTextAlignment(.center)
    }
    
}


#Preview {
    HeaderView(
        title: "Questrade API",
        subtitle: "Example usage."
    )
    .previewSize()
}
