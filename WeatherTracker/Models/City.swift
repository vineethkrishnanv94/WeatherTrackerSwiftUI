//
//  City.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Foundation
struct City: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}
