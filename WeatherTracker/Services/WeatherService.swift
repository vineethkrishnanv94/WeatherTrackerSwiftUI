//
//  WeatherService.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Foundation
import Combine

// MARK: - Protocol
protocol WeatherServiceProtocol {
    func fetchWeather(for cityName: String) -> AnyPublisher<Weather, Error>
}

// MARK: - Service Implementation
class WeatherService: WeatherServiceProtocol {
    
    func fetchWeather(for cityName: String) -> AnyPublisher<Weather, Error> {
        let urlString = Router.getWeatherDetails.path + APIKeys.weatherAPIKey + "&q=" + cityName
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Weather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
