//
//  AppleMapView.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import SwiftUI

struct AppleMapView: View {
    
    @StateObject var viewModel = AppleMapViewModel()
    
    var body: some View {

        ZStack {
            /// Inital Map View
            SNAppleMapView(region: $viewModel.region,
                           pin: $viewModel.pins,
                           mapType: viewModel.mapType,
                           userTrackingMode: viewModel.userTrackingMode,
                           showsUserLocation: viewModel.showUserLocation)
            
            currentLocationButton
        }
       
        .onAppear(perform: {
            viewModel.getCurrentLocation()
        })
        .navigationTitle("Apple Map")
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

struct AppleMapView_Previews: PreviewProvider {
    static var previews: some View {
        AppleMapView()
    }
}
