import SwiftUI


@MainActor @preconcurrency public protocol PageStyle {
    
    typealias Configuration = PageStyleConfiguration
    associatedtype Body : View
    
    @ViewBuilder @MainActor @preconcurrency func makeBody(configuration: Configuration) -> Self.Body
    
}


public struct PageStyleConfiguration {
    
    public struct Header : View {
        
        private let base: AnyView
        init(_ view: some View){ base = AnyView(view) }
        
        public var body: some View { base }
    }
    
    public struct Content : View {
        
        private let base: AnyView
        init(_ view: some View){ base = AnyView(view) }
        
        public var body: some View { base }
    }
    
    public struct Footer : View {
        
        private let base: AnyView
        init(_ view: some View){ base = AnyView(view) }
        
        public var body: some View { base }
    }
    
    let header: Header
    let content: Content
    let footer: Footer
    
}


// MARK: - Automatic


struct AutomaticPageStyle: PageStyle {

    func makeBody(configuration: Configuration) -> some View {
        Page(configuration)
            #if os(watchOS)
            .pageStyle(.inlineScroll)
            #else
            .pageStyle(.prominentFooter)
            #endif
    }
    
}

extension PageStyle where Self == AutomaticPageStyle {
    
    static nonisolated var automatic: Self { .init() }
    
}


// MARK: - InlineScroll


struct InlineScrollPageStyle : PageStyle {

    func makeBody(configuration: Configuration) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                configuration.header
                    .frame(height: 90)
                
                VStack {
                    configuration.content
                }
                
                configuration.footer
            }
            .padding()
            .padding(.vertical)
        }
        .buttonStyle(ButtonStyle())
        .progressViewStyle(ProgressStyle())
        .background(BGMaterial().ignoresSafeArea())
    }
    
}

extension PageStyle where Self == InlineScrollPageStyle {
    
    static nonisolated var inlineScroll: Self { .init() }
    
}


// MARK: - ProminentFooter


struct ProminentFooterPageStyle : PageStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Content(config: configuration)
    }
    
    struct Content: View {
        
        @Environment(\.dismiss) private var dismiss
        @Environment(\.isModal) private var isModal
        
        let config: Configuration
        
        private var dismissButton: some View {
            #if !os(watchOS)
            Button{ dismiss() } label: {
                Text("Done")
            }
            .tint(.primary.opacity(0.4))
            .environment(\.controlProminence, .secondary)
            .environment(\.isPageFooter, true)
            #if !os(tvOS)
            .keyboardShortcut(.cancelAction)
            #endif
            #else
            EmptyView()
            #endif
        }
        
        var body: some View {
            GeometryReader { proxy in
                VStack(spacing: 0) {
                    GeometryReader { p in
                        ScrollView {
                            VStack(spacing: 0) {
                                config.header
                                Spacer(minLength: 0)
                            }
                            .frame(minHeight: 120)
                            .safeAreaInset(edge: .bottom, spacing: 0){
                                VStack {
                                    config.content
                                }
                            }
                            .padding()
                            .frame(minHeight: p.size.height)
                            .frame(maxWidth: .readableWidth)
                            .frame(maxWidth: .infinity)
                        }
                    }

                    Divider().ignoresSafeArea().opacity(0.6)
                    
                    Group {
                        if proxy.size.width > 420 {
                            HStack{
                                if isModal {
                                    dismissButton
                                    Spacer()
                                }
                                
                                config.footer
                                    #if !os(watchOS) && !os(tvOS)
                                    .keyboardShortcut(.defaultAction)
                                    #endif
                            }
                        }
                        else {
                            VStack(spacing: 16) {
                                config.footer
                                    #if !os(watchOS) && !os(tvOS)
                                    .keyboardShortcut(.defaultAction)
                                    #endif
                                
                                if isModal {
                                    dismissButton
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .readableWidth)
                    .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(ButtonStyle())
            .progressViewStyle(ProgressStyle())
            .background(BGMaterial().ignoresSafeArea())
            #if os(macOS)
            .frame(minHeight: isModal ? 460 : nil)
            #endif
        }
        
    }
}


extension PageStyle where Self == ProminentFooterPageStyle {
    
    static nonisolated var prominentFooter: Self { .init() }
    
}



extension EnvironmentValues {
    
    @Entry var pageStyle: any PageStyle = .automatic
    
}


extension View {
    
    func pageStyle<Style: PageStyle>(_ style: Style) -> some View {
        environment(\.pageStyle, style)
    }
    
}


final class PageStyleBox: PageStyle {
    
    let style: any PageStyle
    
    init<Style: PageStyle>(_ style: Style) {
        self.style = style
    }
    
    func makeBody(configuration: Configuration) -> AnyView {
        AnyView(style.makeBody(configuration: configuration))
    }
    
}
