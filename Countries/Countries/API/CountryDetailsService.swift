//
//  CountryDetailsService.swift
//  Countries
//
//  Created by Ceren Çiçek on 8.01.2023.
//

import Foundation

struct CountryDetailsService {

    private let url : URL
    private let API_KEY = "573ba9c781msh18bd260c2e61237p1123c3jsna772523cc287"

    init(countryCode: String) {

        let urlString = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(countryCode)/?rapidapi-key=\(API_KEY)"
        guard let url = URL(string: urlString) else { fatalError() }
        self.url = url

    }

    // gets country detail data through API
    public func getCountryDetails(completion: @escaping(Result<CountryDetail, CountriesError>) -> Void) {

        let session = URLSession.shared

        let dataTask = session.dataTask(with: url) { (data, response, error) in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let countryData = try decoder.decode(CountryDetails.self, from: jsonData)
                completion(.success(countryData.data))
            } catch let jsonError as NSError {
                print(jsonError)
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }

}
