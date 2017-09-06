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

struct NameKey: PreferenceKey {
  let name: String

  typealias PreferenceValueType = Name
  var rawKey: String { return name }
}
