//  Created by Alexander Belyavskiy on 6/22/17.

import Foundation
import Security

public struct KeychainPreferences: Preferences {
  private let accessGroup: String?

  public init(accessGroup: String? = nil) {
    self.accessGroup = accessGroup
  }

  public func get<Key>(_ key: Key) -> Key.PreferenceValueType? where Key: PreferenceKey {
    var query = self.query(forKey: key.rawKey)
    query[kSecReturnData] = kCFBooleanTrue
    query[kSecMatchLimit] = kSecMatchLimitOne

    var result: AnyObject?
    let resultCode: OSStatus = withUnsafeMutablePointer(to: &result) {
      SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
    }
    print(resultCode)

    guard resultCode == noErr,
      let data = result as? Data else {
        return nil
    }

    return Key.PreferenceValueType.decode(data)
  }

  public func set<Key, Value>(_ value: Value?, for key: Key) where Key: PreferenceKey, Value == Key.PreferenceValueType {
    deleteItem(forKey: key.rawKey)

    guard let value = value,
      let encodedData = value.encode() else {
        return
    }

    var query = self.query(forKey: key.rawKey)
    query[kSecValueData] = encodedData

    let status: OSStatus = SecItemAdd(query as CFDictionary, nil)    
    print(status)
  }

  private func deleteItem(forKey key: String) {
    var query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount : key
    ]

    addAccessGroup(to: &query)

    let status = SecItemDelete(query as CFDictionary)
    print(status)
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

