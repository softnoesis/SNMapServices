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
