//  Created by Alexander Belyavskiy on 6/22/17.

import Foundation
import Security

public struct KeychainPreferences: Preferences {
    private let accessGroup: String?
    
    public init(accessGroup: String? = nil) {
        self.accessGroup = accessGroup
    }
    
    public func get<Key>(_ key: Key) throws -> Key.PreferenceValueType? where Key: PreferenceKey {
        var query = self.query(forKey: key.rawKey)
        query[kSecReturnData] = kCFBooleanTrue
        query[kSecMatchLimit] = kSecMatchLimitOne
        
        var result: AnyObject?
        let resultCode: OSStatus = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        guard resultCode == noErr,
            let data = result as? Data else {
                return nil
        }
        
        return try decode(data)
    }
    
    public func set<Key, Value>(_ value: Value?, for key: Key) throws where Key: PreferenceKey, Value == Key.PreferenceValueType {
        deleteItem(forKey: key.rawKey)
        
        guard let value = value else {
            return
        }
        
        let encodedData = try encode(value)
        var query = self.query(forKey: key.rawKey)
        query[kSecValueData] = encodedData
        
        let _: OSStatus = SecItemAdd(query as CFDictionary, nil)
    }
    
    private func deleteItem(forKey key: String) {
        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount : key
        ]
        
        addAccessGroup(to: &query)
        
        let _: OSStatus = SecItemDelete(query as CFDictionary)
    }
    
    private func query(forKey key: String) -> [CFString: Any] {
        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            ]
        addAccessGroup(to: &query)
        return query
    }
    
    private func addAccessGroup(to query: inout [CFString: Any]) {
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup] = accessGroup
        }
    }
}

