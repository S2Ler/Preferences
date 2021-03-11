import XCTest
@testable import Preferences

class PreferencesTests: XCTestCase {
  
  func testKeychain() {
    let preferences = KeychainPreferences()
    let initialValue = Name(first: "alex", second: "b")
    let key = NameKey(name: "main")
    XCTAssertNoThrow(try preferences.set(initialValue, for: key), "")
    let extractedValue = (((try? preferences.get(key)) as NameKey.PreferenceValueType??)).flatMap { $0 }
    XCTAssertNotNil(extractedValue)
    XCTAssertEqual(initialValue.first, extractedValue?.first)
    XCTAssertEqual(initialValue.second, extractedValue?.second)
  }
  
  func testCodable() {
    let preferences = UserDefaults.standard
    let initialValue = Address(street: "Noname", homeNumber: 777)
    let key = AddressKey(name: "my")
    XCTAssertNoThrow(try preferences.set(initialValue, for: key), "")
    let extractedValue = (((try? preferences.get(key)) as AddressKey.PreferenceValueType??)).flatMap { $0 }
    XCTAssertNotNil(extractedValue)
    XCTAssertEqual(initialValue.street, extractedValue?.street)
    XCTAssertEqual(initialValue.homeNumber, extractedValue?.homeNumber)
  }
  
  func testAnyPreferenceKey() {
    let preferences = UserDefaults.standard
    let initialValue = Address(street: "Noname", homeNumber: 777)
    let key = AnyPreferenceKey<Address>(rawKey: "my")
    XCTAssertNoThrow(try preferences.set(initialValue, for: key), "")
    let extractedValue = (((try? preferences.get(key)) as Address??)).flatMap { $0 }
    XCTAssertNotNil(extractedValue)
    XCTAssertEqual(initialValue.street, extractedValue?.street)
    XCTAssertEqual(initialValue.homeNumber, extractedValue?.homeNumber)
  }
  
  func testBundledPreferenceValues() {
    test(initialValue: "InitialValue")
    test(initialValue: -64 as Int)
    test(initialValue: 8 as UInt)
    test(initialValue: 64.0 as Double)
    test(initialValue: 64.0 as Float)
    test(initialValue: Date())
  }
  
  func testGetKeyOfType() {
    let preferences = UserDefaults.standard
    let key = "GetKeyOfType"
    let value = Address(street: "10", homeNumber: 20)
    XCTAssertNoThrow(try preferences.set(value, for: key))
    let extractedValue = try? preferences.get(key, of: Address.self)
    XCTAssertEqual(value, extractedValue)
  }
  
  func test<Value: Codable & Equatable>(initialValue: Value) {
    let preferences = UserDefaults.standard
    let key = AnyPreferenceKey<Value>(rawKey: "aKey")
    XCTAssertNoThrow(try preferences.set(initialValue, for: key), "")
    let extractedValue = (((try? preferences.get(key)) as Value??)).flatMap { $0 }
    XCTAssertEqual(initialValue, extractedValue)
  }
  
  static var allTests = [
    ("testKeychain", testKeychain),
    ("testCodable", testCodable),
    ("testAnyPreferenceKey", testAnyPreferenceKey),
    ("testBundledPreferenceValues", testBundledPreferenceValues),
  ]
  
}
