import Foundation

public class FakeDataProvider: ResponseProvider {
    
    public init(){ }
    
    public func request<T>(_ req: Request, response: (Result<T, Error>) -> Void) where T : Decodable {
        func loadJson(file: URL) {
            do {
                let data = try Data(contentsOf: file, options: .mappedIfSafe)
                let p = try JSONDecoder.quest.decode(T.self, from: data)
                response(.success(p))
            } catch {
                response(.failure(error))
            }
        }
        
        if let path = Bundle.module.path(forResource: "\(T.self)", ofType: "json") {
            loadJson(file: URL(fileURLWithPath: path))
        } else {
            response(.failure(ResponseProviderError.noResponse))
        }
    }
}
