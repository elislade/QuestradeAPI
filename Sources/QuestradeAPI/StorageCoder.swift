
import Foundation

class StorageCoder<Value: Codable> {
    
    private var _value: Value?
    
    public var value: Value? {
        set(newValue) {
            if newValue == nil {
                storage.delete()
            } else {
                save()
            }
            
            _value = newValue
        }
        
        get {
            if let v = _value {
                return v
            } else {
                _value = load()
                return _value
            }
        }
    }
    
    let storage: Storable
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    init(storage: Storable, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.storage = storage
        self.encoder = encoder
        self.decoder = decoder
    }
    
    private func save() {
        if let data = try? encoder.encode(value) {
            storage.set(data)
        }
    }
    
    private func load() -> Value? {
        return try? decoder.decode(Value.self, from: storage.get())
    }
    
}
