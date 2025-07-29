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
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer.ignoresSafeArea()
            
            VStack {
                header
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                
                previewView
            }
        }
        .sheet(
            item: $viewModel.sheetLocationDetail,
            onDismiss: nil,
            content: { location in
                LocationDetailView(location: location)
                    .presentationDetents([.large])
            })
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
                    .fontWeight(.bold)
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
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
        .padding()
    }
    
    private var mapLayer: some View {
        Map(position: $viewModel.mapCamera) {
            ForEach(viewModel.locations) { location in
                Annotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(location == viewModel.mapLocation ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            self.viewModel.showNextLocation(location: location)
                        }
                } label: {}

            }
        }
        .mapStyle(.imagery)
    }
    
    private var previewView: some View {
        ForEach(viewModel.locations) { location in
            if viewModel.mapLocation == location {
                LocationsPreviewView(location: location)
                    .shadow(color: .black.opacity(0.3),
                            radius: 20)
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)))
            }
        }
    }
}

#Preview {
    let viewModel = LocationsViewModel()
    LocationsView(viewModel: viewModel)
        .environment(viewModel)
}
