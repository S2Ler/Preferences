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

public protocol CodablePreferenceValue: PreferenceValue, Codable {
    
}

extension CodablePreferenceValue {
    public static func decode(_ data: Data) -> Self? {
        let decoder = JSONDecoder()
        return try? decoder.decode(self, from: data)
    }
    
    public func encode() -> Data? {
        let coder = JSONEncoder()
        return try? coder.encode(self)
    }
}

public struct AnyPreferenceKey<Value: PreferenceValue>: PreferenceKey {
    public typealias PreferenceValueType = Value
    
    public let rawKey: String
    
    public init<Key: PreferenceKey>(key: Key) {
        self.init(rawKey: key.rawKey)
    }
    
    public init(rawKey: String) {
        self.rawKey = rawKey
    }
}

extension String: PreferenceValue {
    public func encode() -> Data? {
        return data(using: .utf8)
    }

    public static func decode(_ data: Data) -> String? {
        return String(data: data, encoding: .utf8)
    }
}
