//
//  EarthquakeViewModel.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/16/24.
//

import Foundation
import Combine

class EarthquakeViewModel: ObservableObject {
    @Published var earthquakes = [Earthquake]()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchEarthquakes()
    }
    
    func fetchEarthquakes() {
        guard let url = URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EarthquakeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.earthquakes = response.features
            })
            .store(in: &cancellables)
    }
}
