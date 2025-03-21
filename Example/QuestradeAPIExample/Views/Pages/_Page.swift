import SwiftUI

struct Page<Content: View, Header: View, Footer: View>: View {
    
    @Environment(\.pageStyle) private var style
    
    //private let externalConfiguration: PageStyleConfiguration?
    
    let content: Content
    let header: Header
    let footer: Footer
    
    init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer
    ){
        self.content = content()
        self.header = header()
        self.footer = footer()
    }
    
    private var configuration: PageStyleConfiguration {
        PageStyleConfiguration(
            header: .init(header),
            content: .init(content),
            footer: .init(footer.environment(\.isPageFooter, true))
        )
    }
    
    var body: some View {
        AnyView(style.makeBody(configuration: configuration))
    }
    
}


extension Page where Header == PageStyleConfiguration.Header,
                     Content == PageStyleConfiguration.Content,
                     Footer == PageStyleConfiguration.Footer
{
    
    init(_ configuration: PageStyleConfiguration){
        self.content = configuration.content
        self.header = configuration.header
        self.footer = configuration.footer
    }
    
}

extension EnvironmentValues {
    
    @Entry var isPageFooter: Bool = false
    @Entry var isModal: Bool = false
    @Entry var isPresentedOn: Bool = false
    
}


#Preview {
    Page {
        Color.red.opacity(0.1)
            .aspectRatio(0.8, contentMode: .fit)
    } header: {
        HeaderView(title: "Title Text", subtitle: "Subtitle Text")
    } footer: {
        Button(action: {}){
            Label("Footer Action", systemImage: "circle.fill")
        }
    }
    .previewSize()
}


extension View {
    
    func present<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        modifier(PresentModifier(isPresented: isPresented, modal: content))
    }
    
}


struct PresentModifier<Modal: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    @ViewBuilder let modal: Modal
    
    func body(content: Content) -> some View {
        content.transformEnvironment(\.isPresentedOn){ val in
            if isPresented {
                val = true
            }
        }
        .preference(key: HasPresentationPreference.self, value: isPresented)
        .sheet(isPresented: $isPresented){
            modal
                .environment(\.isModal, true)
        }
    }
    
}


struct HasPresentationPreference: PreferenceKey {
    
    static let defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        let next = nextValue()
        if next {
            value = next
        }
    }
}
