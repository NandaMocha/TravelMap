//
//  TravelMapApp.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 28/07/25.
//

import SwiftUI

@main
struct TravelMapApp: App {
    @State private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environment(vm)
        }
    }
}
