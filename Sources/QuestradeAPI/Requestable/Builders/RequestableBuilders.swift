

public protocol RequestableBuilder: Sendable {
    
    associatedtype Output
    
    func build<Request: Requestable>(_ request: Request) throws -> Output
    
}


public protocol RequestableURLBuilder: RequestableBuilder where Output == URLRequest { }
