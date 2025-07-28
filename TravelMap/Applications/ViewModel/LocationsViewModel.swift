//
//  LocationsViewModel.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 28/07/25.
//

import SwiftUI

@Observable class LocationsViewModel {
    var locations: [LocationModel]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
