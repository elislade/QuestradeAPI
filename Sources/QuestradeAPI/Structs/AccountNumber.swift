

public struct AccountNumber: RawRepresentable, Hashable, Codable, Sendable {
    
    public static let validator: any StringValidator = AccountNumberValidator()
    public let rawValue: String
    
    /// Initializer will return nill if does not pass validation.
    public nonisolated init?(rawValue: String) {
        do {
            try Self.validator(rawValue)
        } catch {
            return nil
        }

        self.rawValue = rawValue
    }
    
    /// Initializer will throw error if does not pass validation.
    public nonisolated init(possibleAccountNumber: String) throws {
        try Self.validator(possibleAccountNumber)
        self.rawValue = possibleAccountNumber
    }
    
    /// Initializer will preconditionFail if does not pass validation.
    public nonisolated init(_ possibleAccountNumber: String) {
        do {
            try self.init(possibleAccountNumber: possibleAccountNumber)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }
    
}

extension AccountNumber: CustomStringConvertible {
    
    public var description: String { rawValue }
    
}

extension AccountNumber: ExpressibleByStringInterpolation {

    public init(stringLiteral value: String) {
        self.init(value)
    }
    
}

struct AccountNumberValidator: StringValidator {
    
    public enum Error: Swift.Error {
        case not8DigitsLong
        case notAllDigits
        
        public nonisolated var localizedDescription: String {
            switch self {
            case .not8DigitsLong:
                "Account number must be 8 digits long."
            case .notAllDigits:
                "Account number must consist of only digits."
            }
        }
    }
    
    func validate(_ input: Input) throws {
        if input.count != 8  {
            throw Error.not8DigitsLong
        } else if !(input.map{ $0.isNumber }.allSatisfy{ $0 }) {
            throw Error.notAllDigits
        }
    }
    
}


public protocol Validator: Sendable {
    associatedtype Input
    func validate(_ input: Input) throws
}

public extension Validator {
    
    func callAsFunction(_ input: Input) throws {
        try validate(input)
    }
    
}

public protocol StringValidator: Validator where Input == String { }
