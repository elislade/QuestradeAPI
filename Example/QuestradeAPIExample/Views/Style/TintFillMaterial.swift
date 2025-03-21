import SwiftUI

struct TintFillMaterial<Shape: InsettableShape>: View {
    
    let shape: Shape
    
    init(_ shape: Shape) {
        self.shape = shape
    }
    
    var body: some View {
        ZStack {
            shape
                //.fill(.tint)
                .mask {
                    LinearGradient(
                        colors: [.white.opacity(0.1), .white.opacity(0.3)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                 .shadow(radius: 3, y: 3)
                 .overlay{
                     shape
                         .strokeBorder()
                         .opacity(0.2)
                 }
        }
    }
    
}


#Preview {
    TintFillMaterial(Circle())
        .padding()
        .previewSize()
        .foregroundStyle(.tint)
        .tint(.red)
}
