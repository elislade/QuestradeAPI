

public struct QuestResponseParser: ResponseParser {
    
    public nonisolated init(){ }
    
    public nonisolated func parse<T>(_ data: Data) throws -> T where T : Decodable {
        if let error = try? JSONDecoder().decode(QuestError.self, from: data) {
            throw error
        }
        
        return try QuestDecoder().decode(T.self, from: data)
    }
    
}


extension ResponseParser where Self == QuestResponseParser {
    
    public static nonisolated var quest: Self { QuestResponseParser() }
    
}
