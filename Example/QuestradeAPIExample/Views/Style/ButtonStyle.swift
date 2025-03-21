import SwiftUI

struct ButtonStyle: PrimitiveButtonStyle {
    
    @FocusState private var isFocused
    
    func makeBody(configuration: Configuration) -> some View {
        Button(role: configuration.role, action: configuration.trigger){
           configuration.label
        }
        .buttonStyle(Style(isFocused: isFocused))
        .focused($isFocused)
    }
    
    
    struct Style: SwiftUI.ButtonStyle {
        
        @Environment(\.controlProminence) private var prominence
        @Environment(\.isEnabled) private var isEnabled
        @Environment(\.isModal) private var isModal
        @Environment(\.isPageFooter) private var isPageFooter
        
        var isFocused = false
        
        private var bgOpacity: Double {
            prominence == .primary ? 0.1 : 0
        }
        
        func makeBody(configuration: Configuration) -> some View {
            HStack(spacing: 6) {
                configuration.label
                    .transition(.scale.combined(with: .opacity))
            }
            .opacity(0.8)
            .minimumScaleFactor(0.7)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .font(.headline)
            .foregroundStyle(isFocused ? .black : configuration.isPressed ? .white : .primary)
            #if os(macOS)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(maxWidth: isModal && isPageFooter ? nil : .infinity)
            #else
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            #endif
            //.drawingGroup()
            .background{
                GeometryReader { proxy in
                    ZStack {
                        RoundedRectangle(cornerRadius: proxy.size.height / 3)
                            .opacity(configuration.isPressed ? 1 : 0)
                            
                        TintFillMaterial(RoundedRectangle(cornerRadius: proxy.size.height / 3))
                        
                        if isFocused {
                            FocusedMaterial(RoundedRectangle(cornerRadius: proxy.size.height / 3))
                                .scaleEffect(1.1)
                                .transition(.scale(scale: 0.9).combined(with: .opacity))
                        }
                    }
                }
                .foregroundStyle(
                    isFocused ? AnyShapeStyle(.black) : configuration.role == .destructive ? AnyShapeStyle(.red) : AnyShapeStyle(.tint)
                )
            }
            .opacity(isEnabled ? 1 : 0.5)
            .animation(.interactiveSpring, value: configuration.isPressed)
            .animation(.smooth, value: isFocused)
            #if os(iOS) || targetEnvironment(macCatalyst) || os(visionOS)
            .contentShape(.hoverEffect, RoundedRectangle(cornerRadius: 14))
            .hoverEffect()
            #endif
        }
    }
    
}


#Preview {
    VStack {
        Button(action: {}){
            Label("Normal", systemImage: "plus.viewfinder")
        }
        
        Button(action: {}){
            Label("Disabled", systemImage: "circle.slash")
        }
        .disabled(true)
        
        Divider()
        
        Button(role: .destructive, action: {}){
            Label("Destructive", systemImage: "trash")
        }
    }
    .padding(16)
    .tint(.purple)
    .previewSize()
    .buttonStyle(ButtonStyle())
}

extension EnvironmentValues {
    
    @Entry var controlProminence: Prominence = .primary
    
}

enum Prominence: Equatable, Sendable, BitwiseCopyable {
    case primary
    case secondary
    case tertiary
    case quaternary
}
