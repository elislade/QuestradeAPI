import Foundation
import QuestradeAPI


extension URL {
    
    public static var fakeOAuthResponse: URL {
        var comps = URLComponents(url: .questAuthBase, resolvingAgainstBaseURL: false)
        comps?.queryItems = AuthResponse(
            accessToken: "abc123",
            refreshToken: "abc123",
            apiServer: .questAuthBase,
            tokenType: "auth",
            expiresIn: 300
        ).queryItems
        return comps!.url!
    }
    
}
