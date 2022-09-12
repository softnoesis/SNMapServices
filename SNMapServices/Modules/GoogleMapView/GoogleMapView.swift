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
            SNGoogleMapView(currentLocation: $viewModel.currentLocation,
                            pins: $viewModel.pins,
                            isMyLocationEnabled: viewModel.isShowCurrentLocation,
                            mapType: viewModel.mapType)
            
            currentLocationButton
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
