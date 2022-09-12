//
//  SNMapboxAnnotation.swift
//  SNMapServices
//
//  Created by iChirag on 12/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import Foundation
import Mapbox

class SNMapboxAnnotation: NSObject, MGLAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: String?
    
    init(coordinate: CLLocationCoordinate2D, image: String?) {
        self.coordinate = coordinate
        self.image = image
    }
}

class UserAnnotationView: MGLAnnotationView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setAnnotationView()
    }
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setAnnotationView()
    }
    
    override public init(annotation: MGLAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setAnnotationView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setAnnotationView()
    }
    
    func setAnnotationView() {
        frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        layer.cornerRadius = frame.width / 2
        backgroundColor = UIColor.blue
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 4.0
        
        layer.shadowColor = UIColor.black.withAlphaComponent(0.16).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
    }
}

