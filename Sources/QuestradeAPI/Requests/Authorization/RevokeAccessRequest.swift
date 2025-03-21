

public struct RevokeAccessRequest {
    
    public nonisolated init() { }
    
    public typealias Response = NoResponse

}


extension RevokeAccessRequest: Requestable {
    
    public nonisolated var method: RequestMethod { .post }
    public nonisolated var host: String? { URL.questLoginHost.absoluteString }
    public nonisolated var endpoint: String { "/oauth2/revoke" }
    
}
