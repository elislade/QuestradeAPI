

class QuestEncoder: JSONEncoder, @unchecked Sendable {
    
    override init() {
        super.init()
        self.dateEncodingStrategy = .formatted(QuestDateFormatter())
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}

class QuestDecoder: JSONDecoder, @unchecked Sendable {
    
    override init() {
        super.init()
        self.dateDecodingStrategy = .formatted(QuestDateFormatter())
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}

class QuestDateFormatter: DateFormatter, @unchecked Sendable {
    
    override init() {
        super.init()
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        self.calendar = Calendar(identifier: .iso8601)
        self.timeZone = .init(secondsFromGMT: 0)
        self.locale = .init(identifier: "en_US_POSIX")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


public extension DateInterval {
    
    static nonisolated var last30Days: DateInterval {
        let now = Date()
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: now)!
        return DateInterval(start: thirtyDaysAgo, end: now)
    }
    
    static nonisolated var thisWeek: DateInterval {
        let cal = Calendar.current
        let _start = cal.date(bySetting: .weekday, value: cal.firstWeekday, of: Date())!, start = cal.startOfDay(for: _start)
        return DateInterval(
            start: start,
            end: cal.date(byAdding: .day, value: cal.minimumDaysInFirstWeek, to: start)!
        )
    }
    
    static nonisolated var today: DateInterval {
        let start = Calendar.current.startOfDay(for: Date())
        let end = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: start)!
        return DateInterval(start: start, end: end)
    }
    
    static nonisolated var tillNow: DateInterval {
        DateInterval(
            start: Date(timeIntervalSinceReferenceDate: 0),
            end: Date()
        )
    }
    
}

extension URL {
    
    public static let questPracticeLoginHost: URL = {
        URL(string: "https://practicelogin.questrade.com")!
    }()
    
    public static let questLoginHost: URL = {
        URL(string: "https://login.questrade.com")!
    }()
    
    public static let questAuthBase: URL = {
        URL.questLoginHost.appendingPathComponent("oauth2")
    }()
    
}

extension String {
    
    static func formatted(questDate: Date) -> String {
        let dateFormatter: DateFormatter = {
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return f
        }()
        return dateFormatter.string(from: questDate)
    }

}


public extension AuthResponse {
    
    nonisolated var queryItems: [URLQueryItem] {
        [
            .init(name: "access_token", value: accessToken),
            .init(name: "refresh_token", value: refreshToken),
            .init(name: "api_server", value: apiServer.absoluteString),
            .init(name: "expires_in", value: "\(expiresIn)"),
            .init(name: "token_type", value: tokenType)
        ]
    }
    
}
