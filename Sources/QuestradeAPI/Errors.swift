

public struct QuestError: Equatable, Codable, Sendable {
    
    public let code: QuestErrorCode
    public let message: String
    
}

extension QuestError: LocalizedError {
    
    public nonisolated var errorDescription: String? { "[\(code)] \(message)." }
    
}


public enum QuestErrorCode: Int, CaseIterable, Equatable, Codable, Sendable, BitwiseCopyable {
    
    // 400
    case endpointInvalid = 1001
    case argumentInvalid = 1002
    case argumentLimitExeeded = 1003
    case argumentMissing = 1004
    case requestLengthLimitExceeded = 1005
    case rateLimitExceeded = 1006
    case endpointMethodInvalid = 1012
    case requestInvalid = 1013
    case authHeaderMissing = 1014
    case authHeaderInvalid = 1015
    case authScopeExceeded = 1016
    case accessTokenInvalid = 1017
    case accountNumberNotFound = 1018
    case symbolNotFound = 1019
    case orderNotFound = 1020
    
    // 500
    case businessError = 1007
    case technicalError = 1008
    case unexpectedError = 1009
    case responseInvalid = 1010
    case responseTimeout = 1011
    case undefinedError = 1021
    
    
    public static let validCodeRange: ClosedRange<Int> = {
        let all = Self.allCases.sorted{ $0.rawValue < $1.rawValue }
        return (all.first!.rawValue)...(all.last!.rawValue)
    }()
    
    public nonisolated var httpStatus: Int {
        switch self {
        case .endpointInvalid, .accountNumberNotFound, .symbolNotFound, .orderNotFound: 404
        case .argumentInvalid, .argumentLimitExeeded, .argumentMissing, .requestInvalid, .authHeaderInvalid: 400
        case .requestLengthLimitExceeded: 413
        case .rateLimitExceeded: 429
        case .endpointMethodInvalid: 405
        case .authHeaderMissing, .accessTokenInvalid: 401
        case .authScopeExceeded: 403
        case .businessError, .technicalError, .unexpectedError, .undefinedError: 500
        case .responseInvalid: 502
        case .responseTimeout: 503
        }
    }
    
}


extension QuestErrorCode: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        precondition(Self.validCodeRange.contains(value), "Code \(value) out of range.")
        self.init(rawValue: value)!
    }
    
}



import Foundation

public struct LoggedError: Identifiable, Sendable {
    
    public let id: UUID
    public let date: Date
    public let request: (any Requestable)?
    public let error: Swift.Error
    
    public nonisolated init(
        id: UUID = UUID(),
        date: Date = Date(),
        request: (any Requestable)? = nil,
        _ error: Swift.Error
    ) {
        self.id = id
        self.date = date
        self.request = request
        self.error = error
    }
    
}
