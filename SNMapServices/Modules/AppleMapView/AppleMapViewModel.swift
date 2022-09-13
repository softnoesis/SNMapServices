//
//  AppleMapViewModel.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import MapKit
import SwiftUI

class AppleMapViewModel: NSObject, ObservableObject {

    @Published var region: MKCoordinateRegion
    @Published var pins: [AnnotationPin] = [.t1, .t2, .t3, .t4]
    
    var mapType: MKMapType = .standard
    var userTrackingMode: MKUserTrackingMode = .follow
    var showUserLocation = true
    var mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
    @Published var selectedPinAddress = ""
    
    init(region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))) {
        self.region = region
    }
    
    /// Current Location
    func getCurrentLocation() {
        do {
            if let currentLocation = try UserLocationService.shared.getCurrentLocation() {
                region = MKCoordinateRegion(center: currentLocation, span: mapSpan)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAnnotationTap(_ annotation: SNAppleMapAnnotation) {
        self.region = MKCoordinateRegion(center: annotation.coordinate, span: mapSpan)
        self.selectedPinAddress = ""
        UserLocationService.shared.getAddressFromLatLon(coordinate: annotation.coordinate) { address in
            self.selectedPinAddress = address
        }
    }
}
