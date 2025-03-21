import SwiftUI
import QuestradeAPI

struct ErrorView: View {
    
    @Environment(\.isFocused) private var isFocused
    let error: LoggedError
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                Image(systemName: "exclamationmark.triangle.fill")
                
                Text(error.date, format: .dateTime.month().day().hour().minute())
                    .font(.footnote.bold())
                    .lineLimit(1)
            }
            .foregroundColor(.red)
            
            if let endpoint = error.request?.endpoint {
                Text(endpoint)
                    .font(.headline)
                    .lineLimit(1)
            }
            
            Text(error.error.localizedDescription)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .minimumScaleFactor(0.7)
                .lineLimit(4)
                .opacity(0.6)
        }
        .multilineTextAlignment(.leading)
        .padding()
        .foregroundStyle(.black)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
            FocusedMaterial(RoundedRectangle(cornerRadius: 20))
            RoundedRectangle(cornerRadius: 20)
                .fill(.tint)
                .opacity(0.15)
            
            if isFocused {
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: -12)
                    .strokeBorder(.white, lineWidth: 12)
                    .shadow(radius: 8)
            }
            
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


#Preview {
    ErrorView(
        error: .init(TestError())
    )
    .padding()
    .previewSize()
    .tint(.fakeTint)
}


struct TestError: LocalizedError {
    
    var failureReason: String? { "Fake Preview Error" }
    
    var errorDescription: String? {
        "Yup, that's an error you have. Better get it looked at."
    }
    
}
