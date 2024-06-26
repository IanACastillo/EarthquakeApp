//
//  EarthquakeModel.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/16/24.
//

import Foundation
import CoreLocation

// Model for the Earthquake Data
struct Earthquake: Identifiable, Codable, Hashable {
    let id: String
    let properties: Properties
    let geometry: Geometry
    
    struct Properties: Codable, Hashable {
        let mag: Double
        let place: String
        let time: Int64
    }
    
    struct Geometry: Codable, Hashable {
        let coordinates: [Double]
    }
}

struct EarthquakeResponse: Codable {
    let features: [Earthquake]
}
