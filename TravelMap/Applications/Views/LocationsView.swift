//
//  LocationsView.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 28/07/25.
//

import SwiftUI

struct LocationsView: View {
    @Environment(LocationsViewModel.self) var vm
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Text(location.name)
            }
        }
    }
}

#Preview {
    LocationsView()
        .environment(LocationsViewModel())
}
