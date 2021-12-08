import Foundation

public class FakeDataProvider: ResponseProvider {
    
    public static func data<T: Decodable>(for type: T.Type) throws -> T {
        if let path = Bundle.module.path(forResource: "\(T.self)", ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONDecoder.quest.decode(T.self, from: data)
        } else {
            throw ResponseProviderError.noData
        }
    }
    
    public init(){ }
    
    public func request<T: Decodable>(_ req: Request, response: @escaping Response<T>) {
        do {
            response(.success(try Self.data(for: T.self)))
        } catch {
            response(.failure(error))
        }
    }
}
