
import Foundation

extension JSONEncoder {
    public static let quest: JSONEncoder = {
        let enc = JSONEncoder()
        enc.dateEncodingStrategy = .formatted(.quest)
        return enc
    }()
}

extension JSONDecoder {
    public static let quest: JSONDecoder = {
        let dec = JSONDecoder()
        dec.dateDecodingStrategy = .formatted(.quest)
        return dec
    }()
}

extension DateFormatter {
    public static let quest: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}


extension URL {
    
    public static var questAuthBase: URL {
        URL(string: "https://login.questrade.com/oauth2/")!
    }
    
    public static func questAuthURL(clientId: String, callbackURL: URL) -> URL? {
        let redirectURI = "redirect_uri=\(callbackURL)"
        let responseType = "response_type=token"
        let clientID = "client_id=\(clientId)"
        return URL(string: "authorize?\(clientID)&\(responseType)&\(redirectURI)", relativeTo: .questAuthBase)
    }
}
