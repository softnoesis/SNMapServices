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
                           showsUserLocation: viewModel.showUserLocation) { annotation in
                viewModel.getAnnotationTap(annotation)
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
