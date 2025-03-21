import Foundation


public protocol ResponseParser: Sendable {
    
    func parse<T: Decodable>(_ data: Data) throws -> T
    
}
