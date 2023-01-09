//
//  SavedCountry.swift
//  Countries
//
//  Created by Ceren Çiçek on 8.01.2023.
//

import Foundation

class SavedCountry {
    private init() { }
    static let sharedInstance = SavedCountry()
    var savedCountriesSet = Set<Country>()
}
