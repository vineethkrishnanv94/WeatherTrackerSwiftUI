//
//  CityView.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import SwiftUI

struct CityView: View {
    let city: City
    let onTap: (City) -> Void
    
    var body: some View {
        HStack {
            
            VStack(spacing: 13, content: {
                Text(city.name)
                    .font(.system(size: 20, weight: .semibold, design: .default))
            })
            Spacer()
            ImageConstants.cloudsIcon
                .frame(width: 83, height: 83)
        }
        .padding(.horizontal, 31)
        .frame(height: 117)
        .background(ColorConstants.lightgreyColor).clipShape(RoundedRectangle(cornerRadius:16))
        .padding(.horizontal, 20)
        .onTapGesture {
            onTap(city)
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(city: City(id: 2640373, name: "Philadelphia", region: "Pennsylvania", country: "United States", lat: 39.95, lon: -75.16, url: "philadelphia-pennsylvania-united-states-of-america"), onTap: { city in
            
        })
    }
}
