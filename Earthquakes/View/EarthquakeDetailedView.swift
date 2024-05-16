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
    @State private var mapRegion = MKCoordinateRegion()
    private let minLatitudeDelta: CLLocationDegrees = 0.01
    private let maxLatitudeDelta: CLLocationDegrees = 180.0

    var body: some View {
        VStack {
            MapView(coordinate: CLLocationCoordinate2D(
                latitude: earthquake.geometry.coordinates[1],
                longitude: earthquake.geometry.coordinates[0]),
                    mapRegion: $mapRegion
            )
            .ignoresSafeArea(edges: .all)
            
            HStack {
                Button(action: {
                    zoomIn()
                }) {
                    Text("Zoom In")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    zoomOut()
                }) {
                    Text("Zoom Out")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .onAppear {
            setInitialRegion()
        }
    }
    
    private func setInitialRegion() {
        let coordinate = CLLocationCoordinate2D(
            latitude: earthquake.geometry.coordinates[1],
            longitude: earthquake.geometry.coordinates[0]
        )
        mapRegion = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    }
    
    private func zoomIn() {
        var span = mapRegion.span
        span.latitudeDelta = max(span.latitudeDelta / 2, minLatitudeDelta)
        span.longitudeDelta = max(span.longitudeDelta / 2, minLatitudeDelta)
        mapRegion.span = span
    }
    
    private func zoomOut() {
        var span = mapRegion.span
        span.latitudeDelta = min(span.latitudeDelta * 2, maxLatitudeDelta)
        span.longitudeDelta = min(span.longitudeDelta * 2, maxLatitudeDelta)
        mapRegion.span = span
    }
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    @Binding var mapRegion: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
        
        view.setRegion(mapRegion, animated: true)
    }
}
