
import Foundation

public protocol Storable {
    func get() -> Data
    func set(_ newValue: Data)
    func delete()
}

public protocol AuthProviderDelegate {
    func didSignOut(_ auth: AuthProvider)
    func didAuthorize(_ auth: AuthProvider)
    func didFailToAuthorize(_ auth: AuthProvider, with error: AuthProvider.Error)
    
//    func willMakeRequest(_ questAuth: AuthProvider)
//    func didMakeRequest(_ questAuth: AuthProvider)
}


public protocol APIDelegate {
    func didRecieveError(_ api: API, error: Error)
}

public protocol ResponseProvider {
    func request<T: Decodable>(_ req: Request, response: @escaping Response<T>)
}
