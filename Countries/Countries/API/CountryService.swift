//
//  File.swift
//  Countries
//
//  Created by Ceren Çiçek on 7.01.2023.
//

import Foundation

enum CountriesError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct CountryService {

    let url : URL
    let API_KEY = "573ba9c781msh18bd260c2e61237p1123c3jsna772523cc287"

    init() {

        let urlString = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/?limit=10&rapidapi-key=\(API_KEY)"
        guard let url = URL(string: urlString) else { fatalError() }
        self.url = url

    }

    func getCountries(completion: @escaping(Result<[Country], CountriesError>) -> Void) {

        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { (data, response, error) in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(Data.self, from: jsonData)
                let countries = data.data
                completion(.success(countries))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }

}

