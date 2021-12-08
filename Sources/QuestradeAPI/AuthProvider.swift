
import Foundation

public typealias Completion<T> = (T) -> Void

public class AuthProvider: NSObject {
    
    public enum Error: Swift.Error {
        case authInfoMissing, urlParsingIssue
    }
    
    private let _tokenStorage: StorageCoder<AuthResponse>
    
    var auth: AuthResponse? {
        get { _tokenStorage.value }
        set { _tokenStorage.value = newValue }
    }
    
    public var encoder: JSONEncoder = .quest
    public var decoder: JSONDecoder = .quest
    public var session = URLSession.shared
    public var delegate: AuthProviderDelegate?
    public private(set) var tokenExpiry: Date = Date()
    
    public var isAuthorized: Bool {
        guard auth != nil else { return false }
        return tokenExpiry <= Date()
    }
    
    public init(tokenStore: Storable) {
        self._tokenStorage = StorageCoder<AuthResponse>(storage: tokenStore)
    }
    
    public func revokeAccess(completion: ((Swift.Error?) -> Void)? = nil) {
        let url = URL(string: "revoke", relativeTo: .questAuthBase)!
        
        session.dataTask(with: URLRequest(url: url)){ data, res, err in
            if let e = err {
                completion?(e)
                return
            }
            
            self.auth = nil
            self.delegate?.didSignOut(self)
            completion?(nil)
        }.resume()
    }
    
    public func refreshToken(completion: @escaping Response<AuthResponse>) {
        guard let auth = auth else {
            completion(.failure(Error.authInfoMissing))
            return
        }
        
        let endpoint = "token?grant_type=refresh_token&refresh_token=\(auth.refresh_token)"
        let url = URL(string: endpoint, relativeTo: .questAuthBase)!
        
        session.dataTask(with: URLRequest(url: url)){ data, res, err in
            guard let data = data else {
                completion(.failure(ResponseProviderError.noData))
                return
            }
            
            do {
                let r = try JSONDecoder.quest.decode(AuthResponse.self, from: data)
                self.auth = r
                completion(.success(r))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    public func authorize(from url: URL) {
        if let auth = parseAuthResponse(from: url) {
            self.auth = auth
            self.delegate?.didAuthorize(self)
        }
    }
    
    public func parseAuthResponse(from url: URL) -> AuthResponse? {
        let u = url.absoluteString.replacingOccurrences(of: "#", with: "?")
        guard let items = URLComponents(string: u)?.queryItems else { return nil }
  
        let d = items.reduce(into: [String: String]()) { $0[$1.name] = $1.value }
        
        guard
            let accToken = d["access_token"],
            let refToken = d["refresh_token"],
            let apiURL = URL(string: d["api_server"] ?? ""),
            let exp = Double(d["expires_in"] ?? ""),
            let type = d["token_type"]
        else { return nil }

        tokenExpiry = Date().addingTimeInterval(exp)
        
        return AuthResponse(
            access_token: accToken,
            refresh_token: refToken,
            api_server: apiURL,
            token_type: type,
            expires_in: Int(exp)
        )
    }
}
