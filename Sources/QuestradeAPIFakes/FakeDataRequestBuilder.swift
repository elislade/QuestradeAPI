import Foundation
import QuestradeAPI

public struct FakeDataRequestBuilder: RequestableURLBuilder {
    
    public nonisolated init() {}
    
    public enum Error: Swift.Error {
        case missingFile
    }
    
    public func build<Request>(_ request: Request) throws -> URLRequest where Request : Requestable {
        let resourceName = "\(Request.self)_\(Request.Response.self)"
        guard let url = Bundle.module.url(forResource: "\(resourceName)", withExtension: "json") else {
            throw Error.missingFile
        }
        
        return URLRequest(url: url)
    }
    
}


public extension RequestableURLBuilder where Self == FakeDataRequestBuilder {
    
    static nonisolated var fakeData: Self { FakeDataRequestBuilder() }
    
}
