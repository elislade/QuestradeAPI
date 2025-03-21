import SwiftUI


struct GroupMaterial<Shape: InsettableShape>: View {
    
    let shape: Shape
    
    init(_ shape: Shape) {
        self.shape = shape
    }
    
    var body: some View {
        ZStack {
            shape
                .fill(.primary)
                .opacity(0.08)
            
            shape
                .strokeBorder(lineWidth: 0.5)
                .opacity(0.1)
        }
    }
    
}


#Preview {
    GroupMaterial(Circle())
        .previewSize()
        .padding()
}
