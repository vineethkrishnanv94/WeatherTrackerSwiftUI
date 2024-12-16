//
//  HomeViewModel.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Foundation
import Combine

// MARK: - Protocol
protocol HomeViewModelProtocol: ObservableObject {
    var cityName: String { get set }
    var weatherInfo: Weather? { get }
    var searchResults: [City] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func searchCity(query: String)
    func fetchWeather(for cityName: String)
}

// MARK: - Implementation
class HomeViewModel: HomeViewModelProtocol {
    // MARK: - Published Properties
    @Published var cityName: String = "" {
        didSet {
            if !cityName.isEmpty {
                fetchWeather(for: cityName)
            }
        }
    }
    @Published private(set) var weatherInfo: Weather?
    @Published var searchResults: [City] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private let cityService: CityServiceProtocol
    private let weatherService: WeatherServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(cityService: CityServiceProtocol, weatherService: WeatherServiceProtocol) {
        self.cityService = cityService
        self.weatherService = weatherService
        
        // Load saved city name from UserDefaults
        if let savedCity = UserDefaults.standard.string(forKey: "SelectedCity") {
            self.cityName = savedCity
        }
    }
    
    func searchCity(query: String) {
                
        guard !query.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        cityService.fetchCities(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] cities in
                self?.searchResults = cities
            })
            .store(in: &cancellables)
    }
    
    func fetchWeather(for cityName: String) {
        
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather(for: cityName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] weather in
                self?.weatherInfo = weather
                
                UserDefaults.standard.setValue(cityName, forKey: "SelectedCity")
            })
            .store(in: &cancellables)
    }
    
    func setErrorMessage(message: String?) {
        errorMessage = message
    }
}
