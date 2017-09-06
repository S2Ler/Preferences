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

### Using AnyPreferenceKey



