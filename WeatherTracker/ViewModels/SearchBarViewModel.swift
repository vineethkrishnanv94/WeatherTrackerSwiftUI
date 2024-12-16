//
//  SearchBarViewModel.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Combine

class SearchBarViewModel: ObservableObject {
    @Published var text: String = ""
}
