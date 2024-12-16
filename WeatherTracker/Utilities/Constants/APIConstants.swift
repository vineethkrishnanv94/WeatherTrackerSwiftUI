//
//  Constants.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Foundation

enum APIConstants {
    static var baseURL: String {
        return "api.weatherapi.com/v1/"
    }
    
}


enum Router {
    
    case getCityList
    case getWeatherDetails

    private var scheme: String {
        return "https://"
    }
    
    private var host: String {
        return scheme + APIConstants.baseURL
        
    }
    
    var path: String {
        switch self {
        case .getCityList:
            return host + "search.json?key="
        case.getWeatherDetails:
            return host + "current.json?key="
        }
        
    }
    
    var method: String {
        switch self {

        case .getCityList, .getWeatherDetails:
            return "GET"

        }
    }

}
