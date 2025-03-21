import SwiftUI
import QuestradeAPI
import OSLog

@main
struct QuestradeAPIExampleApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        #endif
    }
    
}


extension CGFloat {
    
    #if os(tvOS)
    static let readableWidth: Self = 820
    #else
    static let readableWidth: Self = 560
    #endif

}


extension Foundation.URL {
    
    static let oAuthCallback: URL = {
        URL(string: "{{callback_url_here}}")!
    }()
    
    static let authURL: URL = AuthURLRequest(
        clientId: "{{client_id_here}}",
        callbackURL: .oAuthCallback
    ).url!
    
}


func logError(_ error: Error){
    if ProcessInfo.processInfo.isXcodePreview {
        print("Error:", error)
    } else {
        os_log(.error, "Error: \(error)")
    }
}

func logDebug(_ string: String){
    if ProcessInfo.processInfo.isXcodePreview {
        print("DEBUG:", string)
    } else {
        os_log(.debug, "\(string)")
    }
}


extension ProcessInfo {
    
    var isXcodePreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
}
