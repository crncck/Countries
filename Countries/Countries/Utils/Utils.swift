//
//  Utils.swift
//  Countries
//
//  Created by Ceren Çiçek on 9.01.2023.
//

import Foundation

class Utils {

    private enum Defaults {
        static let savedCountries = "SavedCountries"
    }

    // saves the country code of the selected country to an array and stores that array in user defaults
    static func saveCountryToUserDefaults(countryCode: String) {
        var savedArray = UserDefaults.standard.object(forKey: Defaults.savedCountries) as? [String] ?? []

        // remove if the current selected country is already in the array
        savedArray.removeAll { (code) -> Bool in
            code == countryCode
        }

        savedArray.append(countryCode)                                               // add the country code
        UserDefaults.standard.set(savedArray, forKey: Defaults.savedCountries)       // save the array to user defaults
        UserDefaults.standard.synchronize()
    }

    // removes the country code of the unselected country from the array and renews the array in user defaults
    static func removeCountryFromUserDefaults(countryCode: String) {
        var savedArray = UserDefaults.standard.object(forKey: Defaults.savedCountries) as? [String] ?? []

        // remove the selected country code from the array
        savedArray.removeAll { (code) -> Bool in
            code == countryCode
        }
        UserDefaults.standard.set(savedArray, forKey: Defaults.savedCountries)      // renew the array in user defaults
        UserDefaults.standard.synchronize()
    }


    // returns saved country code array from user defauls
    static func getSavedCountries() -> [String] {
        return UserDefaults.standard.object(forKey: Defaults.savedCountries) as? [String] ?? []
    }

    // checks if the array in user defaults contains the given country code
    static func checkIfCountryIsSaved(countryCode: String) -> Bool {
        return getSavedCountries().contains(countryCode)
    }


}

