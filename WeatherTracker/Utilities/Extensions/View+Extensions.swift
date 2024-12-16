//
//  View+Extensions.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
