//
//  EarthquakeService.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/17/24.
//

import Foundation
import Combine

class EarthquakeService {
    static let shared = EarthquakeService()
    private var cache = [String: EarthquakeResponse]()
    
    private init() {}
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return URLSession(configuration: configuration)
    }()
    
    func fetchEarthquakes(startTime: String, endTime: String, minMagnitude: Double) -> AnyPublisher<EarthquakeResponse, Error> {
        let urlString = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(startTime)&endtime=\(endTime)&minmagnitude=\(minMagnitude)"
        
        // Check cache first
        if let cachedResponse = cache[urlString] {
            return Just(cachedResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EarthquakeResponse.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { [weak self] response in
                self?.cache[urlString] = response
            })
            .eraseToAnyPublisher()
    }
}
