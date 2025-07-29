//
//  LocationsPreviewView.swift
//  TravelMap
//
//  Created by Nanda Mochammad on 28/07/25.
//

import SwiftUI

struct LocationsPreviewView: View {
    @Environment(LocationsViewModel.self) var viewModel
    
    let location: LocationModel
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack() {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
                .offset(y: 60)
        )
        .clipShape(.rect(cornerRadius: 10))
    }
}

extension LocationsPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(6)
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.headline)
                .fontWeight(.regular)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
    
    private var learnMoreButton: some View {
        Button(action: {
            viewModel.sheetLocationDetail = location
        }, label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button(action: {
            viewModel.nextButtonPressed()
        }, label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        })
        .buttonStyle(.bordered)
    }
}

#Preview {
    ZStack {
        Color.green.ignoresSafeArea()
        
        LocationsPreviewView(location: LocationsDataService.locations[3])
            .environment(LocationsViewModel())
            .padding()
    }
}
