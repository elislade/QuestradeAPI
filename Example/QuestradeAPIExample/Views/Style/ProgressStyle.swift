import SwiftUI

struct ProgressStyle: ProgressViewStyle {
    
    @State private var start = false
    
    func makeBody(configuration: Configuration) -> some View {
        Text("AA")
            .hidden()
            .overlay {
                GeometryReader { proxy in
                    Circle()
                        .strokeBorder(.tint, lineWidth: proxy.size.width / 6)
                        .mask {
                            AngularGradient(colors: [.black, .clear], center: .center)
                        }
                        .rotationEffect(Angle(degrees: start ? 360 : 0))
                        .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: start)
                        .drawingGroup()
                        .onAppear {
                            start = true
                        }
                }
                .aspectRatio(1, contentMode: .fit)
            }
    }
    
}


#Preview {
    ProgressView()
        .progressViewStyle(ProgressStyle())
        .previewSize()
}
