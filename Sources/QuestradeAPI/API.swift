
import Foundation

public class API {
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return f
    }()
    
    public let provider: ResponseProvider
    public var delegate: APIDelegate?
    
    public init(provider: ResponseProvider = FakeDataProvider()) {
        self.provider = provider
    }
    
    func errorMiddleware<T>(_ completion: @escaping Response<T>) -> Response<T> {
        return { res in
            if case .failure(let error) = res {
                self.delegate?.didRecieveError(self, error: error)
            }
            completion(res)
        }
    }
    
    func queryString(_ dict: [String: String?]) -> String {
        var c = URLComponents()
        c.queryItems = dict.compactMap {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return c.url?.relativeString ?? ""
    }
}
