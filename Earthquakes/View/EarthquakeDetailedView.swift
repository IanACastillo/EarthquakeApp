//
//  EarthquakeDetailedView.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/16/24.
//

import SwiftUI
import MapKit
import UIKit

struct EarthquakeDetailView: View {
    let earthquake: Earthquake
    
    var body: some View {
        MapView(coordinate: CLLocationCoordinate2D(
            latitude: earthquake.geometry.coordinates[1],
            longitude: earthquake.geometry.coordinates[0]))
            .ignoresSafeArea(edges: .all)
    }
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        view.setRegion(region, animated: true)
    }
}
