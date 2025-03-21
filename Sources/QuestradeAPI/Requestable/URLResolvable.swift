

public protocol URLResolvable {
    var host: String? { get }
    var port: Int? { get }
    var endpoint: String { get }
    var params: [String : String] { get }
}


public extension URLResolvable {
    
    nonisolated var port: Int? { nil }
    nonisolated var host: String? { nil }
    nonisolated var params: [String: String] { [:] }
    
    nonisolated var url: URL? { resolveURL() }
    
    nonisolated func resolveURL(fallbackHost: String? = nil, fallbackPort: Int? = nil) -> URL? {
        guard
            let host = host ?? fallbackHost,
            let hostURL = URL(string: host),
            let url = URL(string: endpoint, relativeTo: hostURL),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else { return nil }
        
        components.port = port ?? fallbackPort
        
        if !params.isEmpty {
            components.queryItems = params
                .map { .init(name: $0.key, value: $0.value) }
                .sorted { $0.name < $1.name }
        }

        return components.url
    }
    
}
