//
//  PreferencesTests.swift
//  PreferencesTests
//
//  Created by Alexander Belyavskiy on 6/22/17.
//  Copyright © 2017 Alexander Belyavskiy. All rights reserved.
//

import XCTest
@testable import Preferences

class PreferencesTests: XCTestCase {
    
  func testKeychain() {
    let preferences = KeychainPreferences()
    let initialValue = Name(first: "alex", second: "b")
    let key = NameKey(name: "main")
    preferences.set(initialValue, for: key)
    let extractedValue = preferences.get(key)
    XCTAssertNotNil(extractedValue)
    XCTAssertEqual(initialValue.first, extractedValue?.first)
    XCTAssertEqual(initialValue.second, extractedValue?.second)
  }
    
}
