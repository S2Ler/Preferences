import Foundation

public protocol Preferences {
  func get<Key: PreferenceKey>(_ key: Key) throws -> Key.PreferenceValueType?
  func set<Key: PreferenceKey, Value>(_ value: Value?, for key: Key) throws where Key.PreferenceValueType == Value
}

extension Preferences {
    internal func encode<Value: Codable>(_ value: Value) throws -> Data {
        return try JSONEncoder().encode([value])
    }
    
    internal func decode<Value: Codable>(_ data: Data) throws -> Value {
        let boxedValue = try JSONDecoder().decode(Array<Value>.self, from: data)
        return boxedValue.first!
    }
}

public protocol PreferenceKey {
  associatedtype PreferenceValueType: Codable
  var rawKey: String { get }
}
