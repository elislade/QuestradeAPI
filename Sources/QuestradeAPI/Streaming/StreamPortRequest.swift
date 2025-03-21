

public struct StreamPortRequest<Request: Requestable>: Requestable {
    
    public let request: Request
    
    public nonisolated init(_ request: Request) {
        self.request = request
    }
    
    public nonisolated var port: Int? { request.port }
    public nonisolated var host: String? { request.host }
    public nonisolated var endpoint: String { request.endpoint }
    public nonisolated var method: RequestMethod { request.method }
    
    // Inject stream and mode into url param requests
    public nonisolated var params: [String : String] {
        var result = request.params
        result["stream"] = "true"
        result["mode"] = "WebSocket"
        return result
    }
    
    // Inject stream and mode into post body requests
    public nonisolated var body: Data? {
        guard
            let body = request.body,
            var json = try? JSONSerialization.jsonObject(with: body) as? [String: Any]
        else { return nil }
        
        json["stream"] = true
        json["mode"] = "WebSocket"
        
        return try? JSONSerialization.data(withJSONObject: json)
    }
    
    public struct Response: Equatable, Codable, Sendable {
        public let streamPort: Int
    }
    
}


public extension Requestable {
    
    func streamPort() async throws -> Int {
        try await StreamPortRequest(self).response().streamPort
    }
    
}
