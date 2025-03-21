import SwiftUI

struct EnvironmentToggle: View {
    
    @Namespace private var namespace
    @Binding var isFake: Bool
    @FocusState private var isFocusedInside
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { isFake = false }) {
                Text("Real")
                    .padding(isFocusedInside ? 10 : 0)
            }
            .foregroundStyle(!isFake ? Color.black : .primary)
            .background {
                if !isFake {
                    Color.clear.matchedGeometryEffect(id: "BG", in: namespace)
                }
            }
            
            Button(action: { isFake = true }) {
                Text("Fake")
                    .padding(isFocusedInside ? 10 : 0)
            }
            .foregroundStyle(isFake ? Color.black : .primary)
            .background{
                if isFake {
                    Color.clear.matchedGeometryEffect(id: "BG", in: namespace)
                }
            }
        }
        .background {
            FocusedMaterial(Capsule())
                .zIndex(1)
                .matchedGeometryEffect(id: "BG", in: namespace, isSource: false)
        }
        .focused($isFocusedInside)
        .padding(isFocusedInside ? 4 : 2)
        .buttonStyle(ButtonStyle())
        .font(.body.weight(.medium))
        .background{
            Capsule()
                .fill(.tint)
                .opacity(0.3)
        }
        #if os(tvOS)
        .opacity(isFocusedInside ? 1 : 0.8)
        #endif
        .animation(.smooth.speed(1.6), value: isFake)
        .animation(.smooth.speed(1.6), value: isFocusedInside)
    }
    
    
    struct ButtonStyle: SwiftUI.ButtonStyle {
        
        @State private var isHovering: Bool = false
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(2)
                .padding(.horizontal, 8)
                .scaleEffect(configuration.isPressed ? 0.8 : isHovering ? 1.1 : 1)
                .opacity(configuration.isPressed ? 0.5 : 1)
                #if !os(watchOS) && !os(tvOS)
                .onHover{ isHovering = $0 }
                #endif
                .animation(.bouncy.speed(1.6), value: isHovering)
                .animation(.smooth.speed(1.6), value: configuration.isPressed)
        }
        
    }
    
}


#Preview {
    VStack {
        EnvironmentToggle(isFake: .constant(true))
            .tint(.fakeTint)
        
        EnvironmentToggle(isFake: .constant(false))
            .tint(.realTint)
    }
    .padding()
    .previewSize()
}
