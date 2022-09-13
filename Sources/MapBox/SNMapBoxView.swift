//
//  SNMapBoxView.swift
//  SNMapServices
//
//  Created by iChirag on 12/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import Foundation
import Mapbox
import SwiftUI
import CoreLocation
import UIKit

struct SNMapBoxView: UIViewRepresentable {
    
    @Binding var currentRegionCenterLocation: CLLocationCoordinate2D
    
    @Binding var pins: [AnnotationPin]
    
    /// User Tracking Mode
    var userTrackingMode: MGLUserTrackingMode
    
    /// Show Current Location
    var isShowCurrentLocation: Bool
    
    /// Map Style URL
    var mapStyleURL: URL?
    
    ///  Tapped On Annotation
    var handleAnnotationTapped: ((SNMapboxAnnotation) -> Void)?

    /// Show MapBox Logo
    var isShowMapboxLogo = false
    
    /// Default rotation, zoom, pitch, scale enable
    var isPitchEnabled = true
    var isRotateEnabled = true
    var isScrollEnabled = true
    var isZoomEnabled = true
    var showsScale = true
    
    /// Internal Variable
    var zoomLevel: Double = 14
    
    /// Creates the map view object and configures its initial state
    func makeUIView(context: Context) -> MGLMapView {
        let mapView = MGLMapView(frame: context.coordinator.accessibilityFrame, styleURL: mapStyleURL)
        mapView.userTrackingMode = userTrackingMode
        mapView.showsUserLocation = isShowCurrentLocation
        mapView.showsScale = showsScale
        mapView.isPitchEnabled = isPitchEnabled
        mapView.isRotateEnabled = isRotateEnabled
        mapView.isScrollEnabled = isScrollEnabled
        mapView.isZoomEnabled = isZoomEnabled
        mapView.logoView.isHidden = isShowMapboxLogo
        mapView.delegate = context.coordinator
        
        mapView.setCenter(currentRegionCenterLocation, animated: true)
        return mapView
    }
    
    /// Updates the state of the specified view with new information from SwiftUI
    func updateUIView(_ view: MGLMapView, context: Context) {
        view.setCenter(currentRegionCenterLocation, zoomLevel: zoomLevel, animated: true)
        
        if pins.count > 0 {
            let annotation = pins.map { item in
                return SNMapboxAnnotation(coordinate: item.location, image: item.image)
            }
            view.removeAnnotations(view.annotations ?? [])
            view.addAnnotations(annotation)
        }
    }
}

// MARK: - Coordinator and Delegates
extension SNMapBoxView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        let parent: SNMapBoxView
        
        init(_ parent: SNMapBoxView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            if annotation is MGLUserLocation {
                return UserAnnotationView()
            } else if annotation is SNMapboxAnnotation {
                /// Here customize your annotation Pin
                let view = MGLAnnotationView(annotation: annotation, reuseIdentifier: "SNMapboxAnnotationView")
                view.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                if let annotaion = annotation as? SNMapboxAnnotation, let image = annotaion.image {
                    let annotationView = UIHostingController(rootView: SNMapAnnotationView(image: image)).view
                    annotationView?.frame = view.bounds
                    annotationView?.backgroundColor = .clear
                    view.backgroundColor = .clear
                    view.addSubview(annotationView ?? UIView())
                    return view
                }
            }
            return nil
        }
        
        func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
            if annotation is SNMapboxAnnotation {
                if let annotation = annotation as? SNMapboxAnnotation {
                    parent.handleAnnotationTapped?(annotation)
                }
            }
        }
    }
}
