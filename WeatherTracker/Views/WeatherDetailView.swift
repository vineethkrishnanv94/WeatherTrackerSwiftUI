//
//  WeatherDetailView.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import SwiftUI

struct WeatherDetailView: View {
    let weather: Weather
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https:" + weather.current.condition.icon)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 128, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            cityNameView
                .padding(.top, 23)
        }
    }
    
    var cityNameView: some View {
        VStack {
            HStack(spacing: 11) {
                Text(weather.location.name)
                    .font(.system(size: 30, weight: .bold, design: .default))
                
                ImageConstants.locationIcon
                    .frame(width: 21, height: 21)
            }
            
            Text("\(weather.current.tempF, specifier: "%.2f")°")
                .font(.system(size: 70, weight: .bold, design: .default))
            
            tempratureView
            
        }
    }
    
    var tempratureView: some View {
        HStack {
            
            VStack {
                HStack {
                    
                    VStack(spacing: 11){
                        Text(TextConstants.humidity)
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(ColorConstants.darkGrey)
                        
                        Text("\(weather.current.humidity)")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(ColorConstants.grey)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 11){
                        Text(TextConstants.uv)
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(ColorConstants.darkGrey)
                        
                        Text("\(weather.current.uv)")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(ColorConstants.grey)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 11){
                        Text(TextConstants.feelsLike)
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(ColorConstants.darkGrey)
                        
                        Text("\(weather.current.feelslikeF, specifier: "%.2f")°")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(ColorConstants.grey)
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                }
                
                .frame(height: 75)
                .background(ColorConstants.lightgreyColor).clipShape(RoundedRectangle(cornerRadius:16))
                
            }
            .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
    }
}
