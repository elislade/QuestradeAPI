import Foundation

public typealias Response<T: Decodable> = (Result<T, Swift.Error>) -> Void

public enum ResponseProviderError: Error {
    case noData, noResponse
}

extension AuthProvider: ResponseProvider {
    
    public func request<T: Decodable>(_ req: Request, response: @escaping Response<T>) {
        if let token = auth {
            if tokenExpiry <= Date() {
                refreshToken{ res in
                    do {
                        let newToken = try res.get()
                        _req(req.resolveURLRequest(from: newToken))
                    } catch {
                        response(.failure(error))
                    }
                }
            } else {
                _req(req.resolveURLRequest(from: token))
            }
            
        } else {
            response(.failure(Error.authInfoMissing))
        }
        
        func _req(_ urlReq: URLRequest) {
            session.dataTask(with: urlReq){ data, res, err in

                if let e = err {
                    response(.failure(e))
                    return
                }
                
                guard let data = data else {
                    response(.failure(ResponseProviderError.noData))
                    return
                }
                
                guard let res = res as? HTTPURLResponse else {
                    response(.failure(ResponseProviderError.noResponse))
                    return
                }

                if res.statusCode != 200 {
                    let domain = HTTPURLResponse.localizedString(forStatusCode: res.statusCode)
                    let error = NSError(domain: domain, code: res.statusCode, userInfo: res.allHeaderFields as? [String:Any])
                    response(.failure(error))
                } else {
                    if T.self == Data.self {
                        response(.success(data as! T))
                    } else {
                        do {
                            let decoded = try self.decoder.decode(T.self, from: data)
                            response(.success(decoded))
                        } catch {
                            response(.failure(error))
                        }
                    }
                }
            }.resume()
        }
    }
    
}
