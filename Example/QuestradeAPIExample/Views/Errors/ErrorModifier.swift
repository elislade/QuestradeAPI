import SwiftUI
import QuestradeAPI


struct ErrorModifier: ViewModifier {
    
    @Environment(\.isPresentedOn) private var isPresentedOn
    @SceneStorage("ClearedErrorsData") private var clearedData: Data = .init()
    @StateObject private var session = Session.shared
    @State private var hasPresentation = false
    
    private let stride = MemoryLayout<UUID>.stride
    
    private var cleared: Set<UUID> {
        get {
            guard !clearedData.isEmpty else { return [] }
            var count: Int = 0
            var result = Set<UUID>(minimumCapacity: clearedData.count / stride)
            
            while
                clearedData.indices.contains(((count + 1) * stride) - 1),
                let uuid = UUID(clearedData.subdata(in: (count * stride)..<((count + 1) * stride)))
            {
                result.insert(uuid)
                count += 1
            }
            
            return result
        }
        nonmutating set {
            clearedData = newValue.reduce(into: Data(capacity: newValue.count * stride)){ result, partial in
                result.append(partial.data)
            }
        }
    }
    
    private var errors: [LoggedError] {
        hasPresentation || isPresentedOn ? [] : session.errors.filter{ !cleared.contains($0.id) }
    }
    
    private func clear() {
        cleared.formUnion(Set(errors.map(\.id)))
    }
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HasPresentationPreference.self){ has in
                Task { @MainActor in
                    hasPresentation = has
                }
            }
            .modifier(ContentModifier(errors: errors, clear: clear))
    }
    
    
    struct ContentModifier: ViewModifier {

        @Namespace private var ns
        @State private var expanded = false
        
        let errors: [LoggedError]
        let clear: () -> Void
        
        private func toggleExpanded() {
            withAnimation(.smooth.speed(1.6)){
                expanded.toggle()
            }
        }
        
        private func clearAction() {
            toggleExpanded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                clear()
            }
        }
        
        func body(content: Content) -> some View {
            content
                .overlay(alignment: .top){
                    if expanded {
                        ErrorsListView(ns: ns, errors: errors)
                            .background(BGMaterial().ignoresSafeArea())
                    }
                }
                .safeAreaInset(edge: .top, spacing: 0){
                    ZStack {
                        if !errors.isEmpty {
                            if expanded {
                                HStack {
                                    Button(action: toggleExpanded) {
                                        Label{ Text("Collapse errors") } icon : {
                                            Text("A")
                                                .hidden()
                                                .overlay{
                                                    Color.clear
                                                        .aspectRatio(1, contentMode: .fill)
                                                        .overlay {
                                                            Image(systemName: "chevron.compact.up")
                                                                .resizable()
                                                                .scaledToFit()
                                                        }
                                                }
                                        }
                                    }
                                    
                                    Button(role: .destructive, action: clearAction) {
                                        Label{ Text("Clear errors") } icon : {
                                            Text("A")
                                                .hidden()
                                                .overlay{
                                                    Image(systemName: "trash")
                                                        .resizable()
                                                        .scaledToFill()
                                                }
                                        }
                                    }
                                }
                                .buttonStyle(ButtonStyle())
                                .padding()
                                .frame(maxWidth: .maxNotificationWidth)
                                .frame(maxWidth: .infinity)
                                .labelStyle(.iconOnly)
                                #if os(watchOS)
                                .padding(.top, -14)
                                #endif
                                .background{
                                    Rectangle().fill(.background)
                                        .ignoresSafeArea()
                                    Rectangle().fill(.tint).opacity(0.2)
                                        .ignoresSafeArea()
                                }
                                .overlay(alignment: .bottom){
                                    Divider().ignoresSafeArea()
                                }
                                .transition(.offset(y: -170).combined(with: .opacity))
                            } else {
                                Button(action: toggleExpanded) {
                                    ErrorsStackView(ns: ns, errors: errors)
                                }
                                .transition(.offset(y: -270))
                                #if os(tvOS)
                                .buttonStyle(.card)
                                #else
                                .buttonStyle(.plain)
                                #endif
                            }
                        }
                    }
                    .animation(.smooth.speed(1.6), value: errors.count)
                }
                .animation(.smooth.speed(1.6), value: errors.count)
        }
    }
    
}


extension UUID {
    
    var data: Data {
        return Data([
            uuid.00, uuid.01, uuid.02, uuid.03,
            uuid.04, uuid.05, uuid.06, uuid.07,
            uuid.08, uuid.09, uuid.10, uuid.11,
            uuid.12, uuid.13, uuid.14, uuid.15
        ])
    }
    
    init?(_ data: Data){
        guard data.count >= 16 else { return nil }
        self.init(
            uuid: (data[00], data[01], data[02], data[03],
                   data[04], data[05], data[06], data[07],
                   data[08], data[09], data[10], data[11],
                   data[12], data[13], data[14], data[15])
        )
    }
    
}


#Preview {
    BGMaterial()
        .ignoresSafeArea()
        .modifier(ErrorModifier.ContentModifier(
            errors: [
                .init(TestError()),
                .init(TestError()),
                .init(TestError()),
                .init(TestError())
            ],
            clear: {}
        ))
        .previewSize()
        .tint(.realTint)
}


extension CGFloat  {
    
    #if os(tvOS)
    static let maxNotificationWidth: CGFloat = .readableWidth
    #else
    static let maxNotificationWidth: CGFloat = .readableWidth / 1.5
    #endif
    
}
