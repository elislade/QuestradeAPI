

public struct DefaultReponseParser: ResponseParser {
    
    public nonisolated init() {}
    
    public nonisolated func parse<T: Decodable>(_ data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
    
}


extension ResponseParser where Self == DefaultReponseParser {
    
    public static nonisolated var `default`: Self { DefaultReponseParser() }
    
}
