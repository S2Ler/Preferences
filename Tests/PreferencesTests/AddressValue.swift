//
//  AddressValue.swift
//  PreferencesTests
//
//  Created by Aliaksandr Bialiauski on 8/28/17.
//  Copyright © 2017 Alexander Belyavskiy. All rights reserved.
//

import Foundation
import Preferences

struct Address: Codable {
    let street: String
    let homeNumber: Int
}

struct AddressKey: PreferenceKey {
    let name: String
    
    typealias PreferenceValueType = Address
    var rawKey: String { return name }
}
