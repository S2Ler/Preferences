# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- [CodablePreferenceValue](Sources/Preferences.swift) protocol with default [PreferenceValue](Sources/Preferences.swift) implementation for values which conforms to [Codable](https://developer.apple.com/documentation/swift/codable)
- [AnyPreferenceKey](Sources/Preferences.swift) to simplify creation of the keys.
- [SPM](https://swift.org/package-manager/) support
