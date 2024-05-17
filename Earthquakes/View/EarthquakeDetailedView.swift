//
//  EarthquakeDetailedView.swift
//  Earthquakes
//
//  Created by Ian Castillo on 5/16/24.
//

import SwiftUI
import MapKit

struct EarthquakeDetailView: View {
    @ObservedObject var viewModel: EarthquakeDetailViewModel
    
    init(earthquake: Earthquake) {
        _viewModel = ObservedObject(wrappedValue: EarthquakeDetailViewModel(earthquake: earthquake))
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                MapView(coordinate: viewModel.coordinate, mapRegion: $viewModel.mapRegion)
                    .frame(height: geometry.size.height * 7 / 8)
                    .edgesIgnoringSafeArea(.top)
                
                VStack(alignment: .leading, spacing: 5) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Place: \(viewModel.earthquake.properties.place)")
                            .font(.subheadline)
                        Text("Magnitude: \(viewModel.earthquake.properties.mag, specifier: "%.1f")")
                            .font(.subheadline)
                        Text("Coordinates: \(viewModel.coordinate.latitude), \(viewModel.coordinate.longitude)")
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        zoomButton(title: "Zoom In", action: viewModel.zoomIn)
                        zoomButton(title: "Zoom Out", action: viewModel.zoomOut)
                    }
                    .padding(.top, 5)
                    .padding(.horizontal)
                }
                .frame(height: geometry.size.height * 1 / 8)
                .padding(.bottom, 10)
            }
        }
        .navigationTitle("Earthquake Details")
    }
    
    private func zoomButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal, 10)
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
