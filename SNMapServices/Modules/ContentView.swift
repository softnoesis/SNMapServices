//
//  ContentView.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            appleMapButton
            mapBoxMapButton
            googleMapButton
        }
    }
    
    // Buttons
    private var appleMapButton: some View {
        Button {
            
        } label: {
            Text("Apple Map")
        }
    }
    
    private var mapBoxMapButton: some View {
        Button {
            
        } label: {
            Text("MapBox Map")
        }
    }
    
    private var googleMapButton: some View {
        Button {
            
        } label: {
            Text("Google Map")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
