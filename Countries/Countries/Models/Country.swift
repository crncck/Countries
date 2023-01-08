//
//  Country.swift
//  Countries
//
//  Created by Ceren Çiçek on 7.01.2023.
//

import Foundation

struct Data: Decodable {
    let data: [Country]
}

struct Country: Codable, Hashable {
    let code: String
    let name: String
}
