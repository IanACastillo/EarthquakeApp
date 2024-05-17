//
//  ContentView.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = EarthquakeViewModel()
    @State private var selectedEarthquake: Earthquake?
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.earthquakes, id: \.self, selection: $selectedEarthquake) { earthquake in
                NavigationLink(value: earthquake) {
                    earthquakeRow(earthquake)
                        .padding()
                        .background(containerBackgroundColor(for: earthquake))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Earthquakes")
        } detail: {
            if let earthquake = selectedEarthquake {
                EarthquakeDetailView(earthquake: earthquake)
            } else {
                Text("Select an earthquake")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.fetchEarthquakes(startTime: "2023-01-01", endTime: "2024-01-01", minMagnitude: 7.0)
        }
    }
    
    private func containerBackgroundColor(for earthquake: Earthquake) -> Color {
        earthquake.properties.mag >= 7.5 ? Color.red.opacity(0.1) : Color.blue.opacity(0.1)
    }
    
    private func earthquakeRow(_ earthquake: Earthquake) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            placeText(earthquake.properties.place)
            magnitudeText(earthquake.properties.mag)
            timeText(earthquake.properties.time)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func placeText(_ place: String) -> some View {
        Text(place)
            .font(.headline)
            .foregroundStyle(.primary)
    }
    
    private func magnitudeText(_ magnitude: Double) -> some View {
        Text("Magnitude: \(magnitude, specifier: "%.1f")")
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(magnitude >= 7.5 ? .red : .primary)
    }
    
    private func timeText(_ time: Int64) -> some View {
        Text("Time: \(formattedDate(from: time))")
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
    
    private func formattedDate(from timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp / 1000))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
