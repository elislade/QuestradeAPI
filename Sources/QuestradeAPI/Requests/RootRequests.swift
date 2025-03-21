

public struct ServerTimeRequest {
    
    public nonisolated init() {}
    
    public struct Response: Equatable, Codable, Sendable {
        public let time: Date
    }

}


extension ServerTimeRequest: Requestable {
    
    public nonisolated var endpoint: String { "/v1/time" }
    
}
