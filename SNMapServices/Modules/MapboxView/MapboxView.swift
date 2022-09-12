//
//  MapboxView.swift
//  SNMapServices
//
//  Created by iChirag on 12/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import SwiftUI

struct MapboxView: View {
    
    @StateObject var viewModel = MapboxViewModel()
    
    var body: some View {
        ZStack {
            
            SNMapBoxView(currentLocation: $viewModel.currentLocation,
                         pins: $viewModel.pins,
                         userTrackingMode: viewModel.userTrackingMode,
                         isShowCurrentLocation: viewModel.isShowCurrentLocation)
            
            currentLocationButton
        }
        .onAppear(perform: {
            viewModel.getCurrentLocation()
        })
        .navigationTitle("Mapbox Map")
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

struct MapboxView_Previews: PreviewProvider {
    static var previews: some View {
        MapboxView()
    }
}
