//
//  SNGoogleMapView.swift
//  SNMapServices
//
//  Created by iChirag on 12/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import Foundation
import GoogleMaps
import SwiftUI
import CoreLocation
import UIKit

struct SNGoogleMapView: UIViewRepresentable {
    
    @Binding var currentRegionCenterLocation: CLLocationCoordinate2D
    @Binding var pins: [AnnotationPin]
    
    /// Show User Location
    var isMyLocationEnabled: Bool
    
    /// Map Type
    var mapType: GMSMapViewType
    
    ///  Tapped On Annotation
    var handleAnnotationTapped: ((CLLocationCoordinate2D) -> Void)?
    
    /// Defaults Parameter set
    var minZoomlevel = 10.0
    var maxZoomlevel = 20.0
    
    
    /// If set, 3D buildings will be shown where available.  Defaults to YES.
    var isBuildingsEnabled = true
    
    /**
     * Controls whether the map is drawing traffic data, if available.  This is subject to the
     * availability of traffic data.  Defaults to NO.
     */
    var isTrafficEnabled = false
    
    /// Creates the map view object and configures its initial state
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView(frame: context.coordinator.accessibilityFrame)
        mapView.mapType = mapType
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = isMyLocationEnabled
        mapView.isBuildingsEnabled = isBuildingsEnabled
        mapView.isTrafficEnabled = isTrafficEnabled
        mapView.setMinZoom(Float(minZoomlevel), maxZoom: Float(maxZoomlevel))
        
        mapView.camera = GMSCameraPosition(latitude: currentRegionCenterLocation.latitude, longitude: currentRegionCenterLocation.longitude, zoom: 16)
        return mapView
    }
    
    /// Updates the state of the specified view with new information from SwiftUI
    func updateUIView(_ view: GMSMapView, context: Context) {
        view.camera = GMSCameraPosition(latitude: currentRegionCenterLocation.latitude, longitude: currentRegionCenterLocation.longitude, zoom: 16)
        
        CATransaction.begin()
        CATransaction.setValue(2.0, forKey: kCATransactionAnimationDuration)
        let city = GMSCameraPosition.camera(withLatitude: currentRegionCenterLocation.latitude, longitude: currentRegionCenterLocation.longitude, zoom: 16)
        view.animate(to: city)
        CATransaction.commit()
        
        if pins.count > 0 {
            for item in pins {
                let position = item.location
                let marker = GMSMarker(position: position)
                marker.title = item.title
                marker.map = view
            }
        }
    }
}

// MARK: - Coordinator and Delegates
extension SNGoogleMapView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, GMSMapViewDelegate {
        let parent: SNGoogleMapView
        
        init(_ parent: SNGoogleMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            parent.handleAnnotationTapped?(marker.position)
            return true
        }
    }
}
