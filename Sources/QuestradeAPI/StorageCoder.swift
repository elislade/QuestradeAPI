
import Foundation

class StorageCoder<Value: Codable> {
    
    private var _value: Value?
    
    public var value: Value? {
        set(newValue) {
            _value = newValue
            
            if newValue == nil {
                storage.delete()
            } else {
                save()
            }
        }
        
        get { _value }
    }
    
    let storage: Storable
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    init(storage: Storable, encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.storage = storage
        self.encoder = encoder
        self.decoder = decoder
        self._value = load()
    }
    
    private func save() {
        if let data = try? encoder.encode(_value) {
            storage.set(data)
        }
    }
    
    private func load() -> Value? {
        return try? decoder.decode(Value.self, from: storage.get())
    }
    
}
