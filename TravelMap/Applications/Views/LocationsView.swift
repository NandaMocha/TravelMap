//
//  LocationsView.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 28/07/25.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @Bindable var viewModel: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.mapCamera)
                .mapStyle(.standard)
            
            VStack {
                header
                Spacer()
                
                ZStack {
                    ForEach(viewModel.locations) { location in
                        if viewModel.mapLocation == location {
                            LocationsPreviewView(location: location)
                                .shadow(color: .black.opacity(0.3),
                                        radius: 20)
                                .padding()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button {
                viewModel.toggleLocationsList()
            } label: {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        withAnimation {
                            Image(systemName: "chevron.down")
                                .font(.title2)
                                .foregroundStyle(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                        }
                        
                    }
            }
            .foregroundStyle(.primary)
            
            
            if viewModel.showLocationsList {
                LocationsListView(viewModel: viewModel)
            }
        }
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
        .padding()
    }
}

#Preview {
    let viewModel = LocationsViewModel()
    LocationsView(viewModel: viewModel)
        .environment(viewModel)
}
