import SwiftUI

struct BGMaterial<Shape: InsettableShape>: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let shape: Shape
    
    init(_ shape: Shape) {
        self.shape = shape
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                #if os(visionOS)
                shape
                    .fill(.background)
                #else
                switch colorScheme {
                case .light: shape.fill(.white)
                case .dark:  shape.fill(.black)
                @unknown default:
                    shape.fill(.background)
                }
                #endif
                
                shape
                    .fill(.tint)
                    .mask{
                        RadialGradient(
                            colors: [
                                .black.opacity(0.3),
                                .black.opacity(0.1),
                                .black.opacity(0)
                            ],
                            center: .top,
                            startRadius: 0,
                            endRadius: [proxy.size.height, proxy.size.width].sorted().last!
                        )
                    }
            }
        }
    }
}

extension BGMaterial where Shape == Rectangle {
    
    init() {
        self.shape = Rectangle()
    }
    
}


#Preview {
    BGMaterial()
        .ignoresSafeArea()
        .previewSize()
        .tint(.fakeTint)
}
