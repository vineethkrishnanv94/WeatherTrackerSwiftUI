//
//  EmptyStateView.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(TextConstants.noCitySelected)
                .font(.system(size: 30, weight: .semibold, design: .default))
            
            Text(TextConstants.searchForCity)
                .font(.system(size: 15, weight: .semibold, design: .default))
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
    }
}
