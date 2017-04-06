import Foundation

public protocol Preferences {
  func get<Key: PreferenceKey>(_ key: Key) -> Key.PreferenceValueType?
  func set<Key: PreferenceKey, Value>(_ value: Value?, for key: Key) where Key.PreferenceValueType == Value
}

public protocol PreferenceKey {
  associatedtype PreferenceValueType: PreferenceValue
  var rawKey: String { get }
}

public protocol PreferenceValue {
  static func decode(_ data: Data) -> Self?
  func encode() -> Data?
}
