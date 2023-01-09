//
//  CountryManager.swift
//  Countries
//
//  Created by Ceren Çiçek on 9.01.2023.
//

import Foundation

class CountryManager {

    static let shared = CountryManager()

    var countries: [Country] = []

    // returns saved countries as an array
    func filterSavedCountries() -> [Country] {
        let savedCountryCodes = Utils.getSavedCountries()
        return countries.filter { (country) -> Bool in
             savedCountryCodes.contains(country.code)
        }
    }

}
