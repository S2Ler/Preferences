import Foundation

public struct AnyPreferenceKey<Value: Codable>: PreferenceKey {
    public typealias PreferenceValueType = Value
    
    public let rawKey: String
    
    public init<Key: PreferenceKey>(key: Key) {
        self.init(rawKey: key.rawKey)
    }
    
    public init(rawKey: String) {
        self.rawKey = rawKey
    }
}
