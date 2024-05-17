//
//  EarthquakeDetailViewModel.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/17/24.
//

import SwiftUI
import MapKit

final class EarthquakeDetailViewModel: ObservableObject {
    @Published var mapRegion = MKCoordinateRegion()
    let coordinate: CLLocationCoordinate2D
    let earthquake: Earthquake
    
    init(earthquake: Earthquake) {
        self.earthquake = earthquake
        self.coordinate = CLLocationCoordinate2D(
            latitude: earthquake.geometry.coordinates[1],
            longitude: earthquake.geometry.coordinates[0]
        )
        setInitialRegion()
    }
    
    private func setInitialRegion() {
        mapRegion = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    }
    
    func zoomIn() {
        var span = mapRegion.span
        span.latitudeDelta = max(span.latitudeDelta / 2, 0.01)
        span.longitudeDelta = max(span.longitudeDelta / 2, 0.01)
        mapRegion.span = span
    }
    
    func zoomOut() {
        var span = mapRegion.span
        span.latitudeDelta = min(span.latitudeDelta * 2, 180.0)
        span.longitudeDelta = min(span.longitudeDelta * 2, 180.0)
        mapRegion.span = span
    }
}
