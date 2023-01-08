//
//  CountryDetail.swift
//  Countries
//
//  Created by Ceren Çiçek on 8.01.2023.
//

import Foundation

struct CountryDetails: Decodable {
    let data: CountryDetail
}

struct CountryDetail: Decodable {
    let code: String
    let flagImageUri: String
    let name: String
    let wikiDataId: String
}
