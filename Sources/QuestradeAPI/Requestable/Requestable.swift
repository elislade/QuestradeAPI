

public enum RequestMethod: String, Codable, Sendable, BitwiseCopyable {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case create = "CREATE"
    case delete = "DELETE"
}


public protocol Requestable: URLResolvable, Sendable, CustomStringConvertible {
    
    associatedtype Handler: RequestableHandler
    associatedtype Response: Codable & Sendable
    
    var body: Data? { get }
    var method: RequestMethod { get }
    var handler: Handler { get }
    
}

public extension Requestable {
    
    nonisolated var body: Data? { nil }
    nonisolated var method: RequestMethod { .get }
    
    nonisolated var description: String {
        "\(method.rawValue.uppercased()) \(endpoint)"
    }
    
}


public struct NoResponse: Codable, Sendable {
    
    public static let empty: NoResponse = .init()
    
}


