//
//  GoogleMapViewModel.swift
//  SNMapServices
//
//  Created by iChirag on 12/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewModel: NSObject, ObservableObject {

    @Published var currentLocation: CLLocationCoordinate2D
    @Published var pins: [AnnotationPin] = [.t1, .t2, .t3, .t4]
    
    var mapType: GMSMapViewType = .normal
    var isShowCurrentLocation = true
    
    @Published var selectedPinAddress = ""
    
    init(currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708)) {
        self.currentLocation = currentLocation
    }
    
    /// Current Location
    func getCurrentLocation() {
        do {
            if let currentLocation = try UserLocationService.shared.getCurrentLocation() {
                self.currentLocation = currentLocation
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getAnnotationTap(_ annotation: CLLocationCoordinate2D) {
        self.currentLocation = annotation
        self.selectedPinAddress = ""
        UserLocationService.shared.getAddressFromLatLon(coordinate: annotation) { address in
            self.selectedPinAddress = address
        }
    }
}
