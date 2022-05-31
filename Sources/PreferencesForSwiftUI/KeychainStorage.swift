import SwiftUI
import Preferences

@available(macOS 10.15, *)
@propertyWrapper
public struct KeychainStorage<Key: PreferencesKey, Value>: DynamicProperty
where Key.PreferenceValueType == Value {

  public let key: Key
  public let keychainPreferences: KeychainPreferences

  @State private var value: Value?

  public init(
    wrappedValue: Value? = nil,
    key: Key,
    keychainPreferences: KeychainPreferences = .init()
  ) {
    self.key = key
    self.keychainPreferences = keychainPreferences

    do {
      let initialValue = try keychainPreferences.get(key)
      self._value = State<Value?>(initialValue: initialValue)
    }
    catch let error {
      fatalError("\(error)")
    }
  }
  public var wrappedValue: Value? {
    get  {
      value
    }
    nonmutating set {
      value = newValue
      do {
          try keychainPreferences.set(value, for: key)
      }
      catch  {
        assertionFailure("Couldn't set value due to \(error)")
      }
    }
  }

  public var projectedValue: Binding<Value?> {
    Binding(
      get: {
        wrappedValue
      },
      set: {
        wrappedValue = $0
      }
    )
  }
}
