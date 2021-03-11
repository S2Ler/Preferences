import Foundation
import Preferences

struct Name: Codable {
  let first: String
  let second: String
}

struct NameKey: PreferenceKey {
  let name: String

  typealias PreferenceValueType = Name
  var rawKey: String { return name }
}
