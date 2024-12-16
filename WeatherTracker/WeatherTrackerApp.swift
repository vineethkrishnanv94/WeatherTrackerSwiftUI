//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import SwiftUI

@main
struct WeatherTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(cityService: CityService(), weatherService: WeatherService()))
        }
    }
}
