//
//  CityService.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Foundation
import Combine

// MARK: - Protocol
protocol CityServiceProtocol {
    func fetchCities(query: String) -> AnyPublisher<[City], Error>
}

// MARK: - Service Implementation
class CityService: CityServiceProtocol {
    
    func fetchCities(query: String) -> AnyPublisher<[City], Error> {
        let urlString = Router.getCityList.path + APIKeys.weatherAPIKey + "&q=" + query
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [City].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
