import Foundation

extension UserDefaults: Preferences {
  public func get<Key>(_ key: Key) -> Key.PreferenceValueType? where Key: PreferenceKey {
    guard let data = self.data(forKey: key.rawKey) else { return nil }
    return Key.PreferenceValueType.decode(data)
  }

  public func set<Key, Value>(_ value: Value?, for key: Key) where Key: PreferenceKey, Value == Key.PreferenceValueType {
    guard let value = value,
      let encodedData = value.encode() else {
        removeObject(forKey: key.rawKey)
        return
    }

    self.setValue(encodedData, forKey: key.rawKey)
  }
}
