//
//  LocationDetailView.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 29/07/25.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @Environment(LocationsViewModel.self) private var viewModel
    
    let location: LocationModel
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayerSection()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topTrailing) {
            xButtonSection
        }
    }
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.horizontal) { length, axis in
                        return length
                    }
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text(location.cityName)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading) {
            Text(location.description)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.secondary)

            if let url = URL(string: location.link) {
                Link("Read more ...", destination: url)
                    .font(.headline)
                    .padding(.top, 2)
                    .tint(.blue)
            }
        }
    }
    
    private func mapLayerSection() -> some View {
        let mapCamera: MapCameraPosition = .camera(MapCamera(
            centerCoordinate: location.coordinates,
            distance: 1000))
        let map = Map(initialPosition: mapCamera) {
            Annotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(1)
                    .shadow(radius: 10)
            } label: {}
        }
        .allowsHitTesting(false)
        .mapStyle(.imagery)
        .aspectRatio(1, contentMode: .fit)
        .clipShape(.rect(cornerRadius: 10))
        
        return map
    }
    
    private var xButtonSection: some View {
        Button(action: {
            viewModel.sheetLocationDetail = nil
        }, label: {
            Image(systemName: "xmark")
                .foregroundStyle(.black)
                .frame(width: 20, height: 20)
        })
        .padding(8)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 20))
        .padding()
        .shadow(radius: 10)
    }
}

#Preview {
    let viewModel = LocationsViewModel()
    LocationDetailView(location: viewModel.locations[0])
        .environment(viewModel)
}
