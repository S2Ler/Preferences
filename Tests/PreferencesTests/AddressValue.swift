import Foundation
import Preferences

struct Address: Codable, Equatable {
    let street: String
    let homeNumber: Int
}

struct AddressKey: PreferenceKey {
    let name: String
    
    typealias PreferenceValueType = Address
    var rawKey: String { return name }
}
