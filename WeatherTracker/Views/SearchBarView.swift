//
//  SearchBarView.swift
//  WeatherTracker
//
//  Created by Vineeth Krishnan V on 15/12/24.
//

import SwiftUI

struct SearchBarView: View {
    @StateObject private var vm = SearchBarViewModel()
    @Binding var text: String
    let onTextChange: (String) -> Void
    @State private var shouldNotifyTextChange = false
    @State private var isProgrammaticUpdate = false // To suppress API calls
    
    var body: some View {
        ZStack {
            TextField(
                text: $vm.text,
                axis: .horizontal
            ) {
                Text(TextConstants.searchLocation)
                    .foregroundColor(ColorConstants.darkGrey)
            }
            .onReceive(
                vm.$text
                    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            ) { newValue in
                guard shouldNotifyTextChange, !isProgrammaticUpdate, !newValue.isEmpty else {
                    isProgrammaticUpdate = false // Reset after suppression
                    return
                }
                text = newValue // Update the binding value
                onTextChange(newValue)
            }
            .onChange(of: text) { newText in
                if vm.text != newText {
                    isProgrammaticUpdate = true // Suppress API call for programmatic updates
                    vm.text = newText
                }
            }
            .onAppear {
                vm.text = text
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    shouldNotifyTextChange = true
                }
            }
            .foregroundColor(Color.black)
            .padding(.leading, 20)
            .frame(height: 46)
        }
    }
}




