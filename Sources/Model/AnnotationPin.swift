//
//  AnnotationPin.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import UIKit
import CoreLocation

struct AnnotationPin : Identifiable {
    var id = UUID().uuidString
    var title: String
    var location: CLLocationCoordinate2D
    var image: String
}

extension AnnotationPin {
    static let t1 = AnnotationPin(title: "1", location: CLLocationCoordinate2D(latitude: 40.779591, longitude: -73.981726), image: "location")
    static let t2 = AnnotationPin(title: "1", location: CLLocationCoordinate2D(latitude: 40.749600, longitude: -73.981736), image: "location")
    static let t3 = AnnotationPin(title: "1", location: CLLocationCoordinate2D(latitude: 40.746787, longitude: -74.001262), image: "location")
    static let t4 = AnnotationPin(title: "1", location: CLLocationCoordinate2D(latitude: 40.755433, longitude: -73.979329), image: "location")
}
