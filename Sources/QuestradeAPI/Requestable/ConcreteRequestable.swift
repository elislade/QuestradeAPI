

public struct ConcreteRequestable<Response: Codable & Sendable>: Requestable & Codable {
    
    public var host: String? = nil
    public var port: Int? = nil
    public var endpoint: String
    public var params: [String : String] = [:]
    public var method: RequestMethod = .get
    public var body: Data? = nil
    
    public nonisolated init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    public nonisolated init<Request: Requestable>(_ request: Request) {
        self.port = request.port
        self.method = request.method
        self.endpoint = request.endpoint
        self.host = request.host
        self.params = request.params
        self.body = request.body
    }
    
}


public extension Requestable {
    
    nonisolated var concrete: ConcreteRequestable<Response> {
        ConcreteRequestable(self)
    }
    
    nonisolated func withConcrete<Value>(_ key: WritableKeyPath<ConcreteRequestable<Response>, Value>, value: Value) -> ConcreteRequestable<Response> {
        var concrete = concrete
        concrete[keyPath: key] = value
        return concrete
    }
    
}
