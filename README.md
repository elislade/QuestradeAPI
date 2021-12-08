# QuestradeAPI

## Getting Started


The QuestAPI is made up of two main concepts:
1. ResponseProviders
2. API


## ResponseProviders
The job of the provider is to return data to `API` for a given request. QuestradeAPI comes with two providers, `AuthProvider` and `FakeDataProvider`. You can conform to `ResponseProvider` and build your own providers if you have extra custom behaviour that you need. To use a given provider just pass the provider to the initilization of `API`.

```
let api = API(provider: CustomProvider())
```

### AuthProvider
The `AuthProvider` class requires a class or struct that conforms to `Storable`. The purpose of `AuthProvider` is for authorizing and deauthorizing requests for the `API`.

```
let auth = AuthProvider(tokenStore: TokenStore())
```

#### Token Store
The `Storable` protocol is for you to conform to so that you can choose how to securly store the api token.
```
class TokenStore: Storable {
    // func get() -> Data
    // func set(_ data: Data)
    // func delete()
}
```

### FakeDataProvider
A `ResponseProvider` that loads fake responses from json files and supplies them as responses. This provider is used by default for `API` if none is provided on init.


## API
The `API` class can be initilized with or without an authorizer(`AuthProvider`). If no authorizor is supplied on initilization, a default of FakeDataProvider will be used.

```
let api = API(provider: auth)

api.accounts { res in
    switch res {
    case .failure(let error): // log error
    case .success(let actResponse):
        let accounts = actResponse.accounts
    }
}
```

## Full Init Code

```
class MyAPI {

    let loginLink = URL.questAuthURL(
        clientId: "aFsd42sf234FGsdf",
        callbackURL: URL(string: "https://myurl.com/auth-redirect")!
    )
    
    let authProvider = AuthProvider(tokenStore: TokenStore())
    lazy var api: API = { API(provider: authProvider) }()
    
    private(set) var accounts: Set<Account> = []
    
    init() {
        authProvider.delegate = self
    }

    func singIn() {
        // present loginLink
        // user goes through oAuth steps
        // once steps are completed 
        // recieve url from quests oAuth and pass to the authorize from url method.
        authProvider.authorize(from: url)
    }
    
}

extension MyAPI: AuthProviderDelegate {
    func didAuthorize(_ auth: AuthProvider){
        api.accounts{ res in
            do {
                self.accounts.update(try res.get().accounts)
            } catch {
                //TODO: handle error
            }
        }
    }
}
```


## Author
* **Eli Slade** - [Eli Slade](https://github.com/elislade)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

