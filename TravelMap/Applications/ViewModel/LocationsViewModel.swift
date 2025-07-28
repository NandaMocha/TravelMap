//
//  LocationsViewModel.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 28/07/25.
//

import SwiftUI
import MapKit

@Observable
class LocationsViewModel {
    var locations: [LocationModel]
    var mapLocation: LocationModel {
        didSet {
            updateMap(location: mapLocation)
        }
    }
    
    var mapCamera: MapCameraPosition = .camera(MapCamera(
                                                centerCoordinate: CLLocationCoordinate2D(
                                                        latitude: 41.8902,
                                                        longitude: 12.4922),
                                                distance: 1000))
    
    var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMap(location: locations.first!)
    }
    
    private func updateMap(location: LocationModel) {
        withAnimation(.easeInOut) {
            self.mapCamera = .camera(MapCamera(centerCoordinate: location.coordinates,
                                               distance: 1000))
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: LocationModel) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
}
