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
    
    func testCodable() {
        let preferences = UserDefaults.standard
        let initialValue = Address(street: "Noname", homeNumber: 777)
        let key = AddressKey(name: "my")
        preferences.set(initialValue, for: key)
        let extractedValue = preferences.get(key)
        XCTAssertNotNil(extractedValue)
        XCTAssertEqual(initialValue.street, extractedValue?.street)
        XCTAssertEqual(initialValue.homeNumber, extractedValue?.homeNumber)
    }
    
    func testAnyPreferenceKey() {
        let preferences = UserDefaults.standard
        let initialValue = Address(street: "Noname", homeNumber: 777)
        let key = AnyPreferenceKey<Address>(rawKey: "my")
        preferences.set(initialValue, for: key)
        let extractedValue = preferences.get(key)
        XCTAssertNotNil(extractedValue)
        XCTAssertEqual(initialValue.street, extractedValue?.street)
        XCTAssertEqual(initialValue.homeNumber, extractedValue?.homeNumber)
    }

    func testBundledStringPreferenceValue() {
        let preferences = UserDefaults.standard
        let initialValue = "Initial"
        let key = AnyPreferenceKey<String>(rawKey: "aKey")
        preferences.set(initialValue, for: key)
        let extractedValue = preferences.get(key)
        XCTAssertEqual(initialValue, extractedValue)
    }

    static var allTests = [
      ("testKeychain", testKeychain),
      ("testCodable", testCodable),
      ("testAnyPreferenceKey", testAnyPreferenceKey),
      ]

}
