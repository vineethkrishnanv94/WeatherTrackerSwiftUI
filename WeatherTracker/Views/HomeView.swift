//
//  HomeView.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Combine
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @FocusState private var searchIsFocused: Bool
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                searchField
                
                if !viewModel.searchResults.isEmpty {
                    
                    cityList
                }
                
                else {
                    
                    if viewModel.cityName.isEmpty && !viewModel.isLoading {
                        
                        emptyStateView
                        
                    } else if let weather = viewModel.weatherInfo {
                        WeatherDetailView(weather: weather)
                        Spacer()
                    } else {
                        
                        emptyStateView
                    }
                }
                
            }
            .padding(.top, 16)
            
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK"), action: {
                        viewModel.setErrorMessage(message: nil)
                    })
                )
            }
            
            
            
        }
    }
    
    var emptyStateView: some View {
        VStack{
            Spacer()
            EmptyStateView()
            Spacer()
        }
    }
    
    
    var searchField: some View {
        HStack {
            
            SearchBarView(text: $viewModel.cityName) { searchQuery in
                viewModel.searchCity(query: searchQuery)
            }
            .focused($searchIsFocused)
            
            ImageConstants.searchIcon.frame(width: 17.49, height: 17.49)
                .padding(.horizontal, 20.5)
        }
        .background(ColorConstants.lightgreyColor.clipShape(RoundedRectangle(cornerRadius:16)))
        .padding(.horizontal, 24)
    }
    
    var cityList: some View {
        List(viewModel.searchResults, id: \.id) { city in
            CityView(city: city) { city in
                hideKeyboard()
                viewModel.cityName = city.name
                searchIsFocused = false
                viewModel.searchResults = []
            }
            .frame(height: 117)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(
            cityService: CityService(),
            weatherService: WeatherService()
        ))
    }
}
