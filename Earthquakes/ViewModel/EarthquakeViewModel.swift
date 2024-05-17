//
//  EarthquakeViewModel.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/16/24.
//

import Foundation
import Combine

final class EarthquakeViewModel: ObservableObject {
    @Published private(set) var earthquakes = [Earthquake]()
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = false
    @Published var error: Error?

    init() {
        fetchEarthquakes(startTime: "2023-01-01", endTime: "2024-01-01", minMagnitude: 7.0)
    }

    func fetchEarthquakes(startTime: String, endTime: String, minMagnitude: Double) {
        isLoading = true
        error = nil

        EarthquakeService.shared.fetchEarthquakes(startTime: startTime, endTime: endTime, minMagnitude: minMagnitude)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.earthquakes = response.features
            })
            .store(in: &cancellables)
    }
}
