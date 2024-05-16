//
//  ContentView.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = EarthquakeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.earthquakes) { earthquake in
                NavigationLink(destination: EarthquakeDetailView(earthquake: earthquake)) {
                    VStack(alignment: .leading) {
                        Text(earthquake.properties.place)
                            .font(.headline)
                        Text("Magnitude: \(earthquake.properties.mag, specifier: "%.1f")")
                            .font(.subheadline)
                            .foregroundColor(earthquake.properties.mag >= 7.5 ? .red : .black)
                    }
                }
            }
            .navigationTitle("Earthquakes")
        }
    }
}
