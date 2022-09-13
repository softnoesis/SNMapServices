//
//  SNAppleMapView.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import MapKit
import SwiftUI
import UIKit
import CoreLocation

struct SNAppleMapView: UIViewRepresentable {
    
    /// Creating a region
    @Binding var region: MKCoordinateRegion
    
    /// Annotation Pin
    @Binding var pin: [AnnotationPin]
    
    /// Map Type
    var mapType: MKMapType
    
    /// User Tracking Mode
    var userTrackingMode: MKUserTrackingMode
    
    ///  Set to YES to add the user location annotation to the map and start updating its location
    var showsUserLocation: Bool
    
    ///  Tapped On Annotation
    var handleAnnotationTapped: ((SNAppleMapAnnotation) -> Void)?
    
    /// Zoom and scroll are enabled by default.
    var isZoomEnabled: Bool = true
    var isScrollEnabled: Bool = true
    
    var showsBuildings: Bool = false // Affects MKMapTypeStandard
    var showsTraffic: Bool = false// Affects MKMapTypeStandard and MKMapTypeHybrid

    /// Rotate and pitch are enabled by default on Mac OS X and on iOS 7.0 and later.
    var isRotateEnabled: Bool = true
    var isPitchEnabled: Bool = true
    var showsCompass: Bool = true
    var showsScale: Bool = true
    
    /// Creates the map view object and configures its initial state
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: context.coordinator.accessibilityFrame)
        mapView.delegate = context.coordinator
        mapView.mapType = mapType
        mapView.showsUserLocation = showsUserLocation
        mapView.userTrackingMode = userTrackingMode
        mapView.isZoomEnabled = isZoomEnabled
        mapView.isScrollEnabled = isScrollEnabled
        mapView.showsBuildings = showsBuildings
        mapView.showsTraffic = showsTraffic
        mapView.isRotateEnabled = isRotateEnabled
        mapView.isPitchEnabled = isPitchEnabled
        mapView.showsCompass = showsCompass
        mapView.showsScale = showsScale
        let region = mapView.regionThatFits(region)
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    /// Updates the state of the specified view with new information from SwiftUI
    func updateUIView(_ view: MKMapView, context: Context) {
        let region = view.regionThatFits(region)
        view.setRegion(region, animated: true)
        
        if pin.count > 0 {
            let annotation = pin.map { item in
                return SNAppleMapAnnotation(coordinate: item.location, image: item.image)
            }
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotation)
        }
    }
    
}

// MARK: - Coordinator and Delegates
extension SNAppleMapView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        let parent: SNAppleMapView
        
        init(_ parent: SNAppleMapView) {
            self.parent = parent
        }
        
        // MARK: MKMapViewDelegate
        public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if view.annotation is SNAppleMapAnnotation {
                if let annotation = view.annotation as? SNAppleMapAnnotation {
                    parent.handleAnnotationTapped?(annotation)
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                /// Here customize current location icon
               return MKUserLocationView()
            } else if annotation is SNAppleMapAnnotation {
                /// Here customize your annotation Pin
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "SNMapAnnotationView")
                view.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                if let annotaion = annotation as? SNAppleMapAnnotation, let image = annotaion.image {
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
    }
}

