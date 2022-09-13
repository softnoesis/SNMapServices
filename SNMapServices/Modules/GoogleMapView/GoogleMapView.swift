//
//  GoogleMapView.swift
//  SNMapServices
//
//  Created by iChirag on 12/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import SwiftUI

struct GoogleMapView: View {
    
    @StateObject var viewModel = GoogleMapViewModel()
    var body: some View {
        ZStack {
            SNGoogleMapView(currentRegionCenterLocation: $viewModel.currentLocation,
                            pins: $viewModel.pins,
                            isMyLocationEnabled: viewModel.isShowCurrentLocation,
                            mapType: viewModel.mapType) { location in
                viewModel.getAnnotationTap(location)
            }
            
            currentLocationButton
            
            if !viewModel.selectedPinAddress.isEmpty {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(viewModel.selectedPinAddress)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(.blue)
                    .cornerRadius(12)
                }
                .animation(.easeIn(duration: 0.5), value: !viewModel.selectedPinAddress.isEmpty)
                .transition(.scale.combined(with: .move(edge: .bottom)))
                .padding(.bottom, 70)
                .padding(.horizontal, 16)
               
            }
        }
        .onAppear(perform: {
            viewModel.getCurrentLocation()
        })
        .navigationTitle("Google Map")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var currentLocationButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Button {
                    viewModel.getCurrentLocation()
                } label: {
                    Image("navigation")
                       
                }
                .frame(width: 48, height: 48)
                .background(.white)
                .cornerRadius(8)
                
                .padding()

            }
        }
    }
}

struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView()
    }
}
