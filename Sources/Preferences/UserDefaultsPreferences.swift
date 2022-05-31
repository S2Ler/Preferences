import Foundation

extension UserDefaults: Preferences {
    public func get<Key>(_ key: Key) throws -> Key.PreferenceValueType? where Key: PreferenceKey {
        guard let data = self.data(forKey: key.rawKey) else { return nil }
        return try decode(data)
    }
    
    public func set<Key, Value>(_ value: Value?, for key: Key) throws where Key: PreferenceKey, Value == Key.PreferenceValueType {
        guard let value = value else {
            removeObject(forKey: key.rawKey)
            return
        }
        
        let encodedData = try encode(value)
        self.setValue(encodedData, forKey: key.rawKey)
    }
}
