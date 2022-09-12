//
//  ContentView.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//

import SwiftUI

enum Map: String, Hashable {
    case apple = "AppleMap"
    case google = "GoogleMap"
    case mapbox = "MapboxMap"
}

struct ContentView: View {
    @State private var selection: Map? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20.0) {
                NavigationLink(destination: AppleMapView(), tag: Map.apple, selection: $selection) { EmptyView() }
                appleMapButton
                
                NavigationLink(destination: MapboxView(), tag: Map.mapbox, selection: $selection) { EmptyView() }
                mapBoxMapButton
                
                NavigationLink(destination: GoogleMapView(), tag: Map.google, selection: $selection) { EmptyView() }
                googleMapButton
            }
            .navigationTitle("SNMapServices")
            .onAppear {
                getCurrentLocationPermission()
            }
        }
    }
    
    // Buttons
    private var appleMapButton: some View {
        Button {
            selection = .apple
        } label: {
            Text("Apple Map")
        }
    }
    
    private var mapBoxMapButton: some View {
        Button {
            selection = .mapbox
        } label: {
            Text("MapBox Map")
        }
    }
    
    private var googleMapButton: some View {
        Button {
            selection = .google
        } label: {
            Text("Google Map")
        }
    }
    
    private func getCurrentLocationPermission() {
        do {
           let currentLocation = try UserLocationService.shared.getCurrentLocation()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
