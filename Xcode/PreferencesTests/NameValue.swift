//
//  PreferenceValue.swift
//  PreferencesTests
//
//  Created by Alexander Belyavskiy on 6/22/17.
//  Copyright © 2017 Alexander Belyavskiy. All rights reserved.
//

import Foundation
import Preferences

struct Name: Codable {
  let first: String
  let second: String
}

extension Name: PreferenceValue {
  func encode() -> Data? {
    let encoder = JSONEncoder()
    return try? encoder.encode(self)
  }

  static func decode(_ data: Data) -> Name? {
    let decoder = JSONDecoder()
    return try? decoder.decode(Name.self, from: data)
  }
}

struct NameKey: PreferenceKey {
  let name: String

  typealias PreferenceValueType = Name
  var rawKey: String { return name }
}
