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
    var pin = [AnnotationPin]()
    
    /// Creates the map view object and configures its initial state
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.userTrackingMode = .follow
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
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "UserLocation")
                view.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
                view.image = UIImage(named: "")
                return view
            }
            return nil
        }
    }
}

