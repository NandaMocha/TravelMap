//
//  LocationModel.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 28/07/25.
//

import Foundation
import MapKit

struct LocationModel: Identifiable, Equatable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    //Identifiable
    var id: String {
        name + cityName
    }
    
    //Equatable
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        lhs.id == rhs.id
    }
}
