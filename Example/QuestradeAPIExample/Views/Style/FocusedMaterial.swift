import SwiftUI


struct FocusedMaterial<Shape: InsettableShape>: View {
    
    let shape: Shape
    
    init(_ shape: Shape) {
        self.shape = shape
    }
    
    var body: some View {
        ZStack {
            
            #if !os(watchOS)
            shape.fill(.thinMaterial)
            #endif
            
            shape
                 .fill(.linearGradient(
                    colors: [.white.opacity(0.6), .white],
                    startPoint: .top,
                    endPoint: .bottom
                 ))
                 .shadow(
                    color: .black.opacity(0.2),
                    radius: 3,
                    y: 3
                 )
                 .overlay{
                     shape
                         .strokeBorder(Color.white)
                 }
        }
    }
    
}


#Preview {
    FocusedMaterial(Circle())
        .padding()
        .previewSize()
}
