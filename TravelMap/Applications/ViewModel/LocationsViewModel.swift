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
    var sheetLocationDetail: LocationModel?
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations[3]
        
        self.updateMap(location: locations[3])
    }
    
    private func updateMap(location: LocationModel) {
        withAnimation(.easeInOut) {
//            self.mapCamera = .camera(MapCamera(centerCoordinate: location.coordinates,
//                                               distance: 1400, heading: 100, pitch: 45))
            self.mapCamera = .camera(MapCamera(centerCoordinate: location.coordinates, distance: 15000))
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
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else { return }
        
        var nextIndex = currentIndex + 1
        if nextIndex > locations.count-1 {
            nextIndex = 0
        }
        
        showNextLocation(location: locations[nextIndex])
    }
}
