# Preferences

[![swift](https://img.shields.io/badge/swift-4.0+-orange.svg)](https://github.com/diejmon/Preferences/releases)
[![platform](https://img.shields.io/badge/Platform-iOS-orange.svg)](https://apple.com/)
[![spm](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)

Preferences is Simple, Extensible, Strongly Typed UserDefaults/Keychain/[Put Yours] for iOS, macOS, tvOS (macOS, tvOS support comming soon).

## Usage

Instantiate your variant of preferences:
```swift
let preferences = KeychainPreferences() // or UserDefaults.standard
```

### Define Key

With `AnyPreferenceKey`:
```swift
let key = AnyPreferenceKey<String>(rawKey: "aKey")
```

With custom key conforming to protocol `PreferenceKey`:
```swift
struct AddressKey: PreferenceKey {
    let name: String

    typealias PreferenceValueType = String
    var rawKey: String { return name }
}

let key = AddressKey(name: "aKey")
```

`PreferenceKey` have an assosiated type which should conform to `Codable` protocol. You can save to preferences anything that conforms to `Codable` including `String`, `Date`, `Int`, etc. 

### Set Value

Set a value with AnyPreferenceKey:
```swift
try preferences.set("PreferenceValue", for: key)
```

### Get Value

```swift
let value: String? = try preferences.get(key)
```

### Remove Value

```swift
try preferences.set(nil, for: key)
```

### Complex example

Define value:
```swift
struct Name: Codable {
  let first: String
  let second: String
}
```

Define key:
```swift
struct NameKey: PreferenceKey {
  let name: String

  typealias PreferenceValueType = Name
  var rawKey: String { return name }
}
```

Use:
```swift
let preferences = KeychainPreferences()

let myName = Name(first: "Alex", second: "B")
let currentUserKey = NameKey(name: "com.app.current_user")

do {
    try preferences.set(myName, for: currentUserKey)
    let savedValue: Name? = try preferences.get(currentUserKey)
    print("Saved value: \(String(describing: savedValue))")
}
catch {
    print("Can't save value with error: \(error)")
}

```

### Custom Preferences

- Step 1: Create a type that conforms to `Preferences`. 
- Step 2: Use 🙂 
- Step 3: Submit pull request, so that I can consider including your preferences in a standard bundle if it makes sense.

## Links
- [Changelog](CHANGELOG.md)


