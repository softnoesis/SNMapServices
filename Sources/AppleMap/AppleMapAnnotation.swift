//
//  AppleMapAnnotation.swift.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit

class SNAppleMapAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: String?
    
    init(coordinate: CLLocationCoordinate2D, image: String?) {
        self.coordinate = coordinate
        self.image = image
    }
}

struct SNMapAnnotationView: View {
    var image = ""
    var body: some View {
       Image(image)
            .background(Color.clear)
            .scaledToFit()
            .frame(width: 32, height: 32)
            .cornerRadius(16)
    }
}
