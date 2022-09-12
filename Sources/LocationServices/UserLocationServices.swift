//
//  UserLocationServices.swift
//  SNMapServices
//
//  Created by iChirag on 12/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import Combine
import CoreLocation
import Foundation

enum UserLocationServiceError: Error, LocalizedError {
    case permissionRestricted
    case permissionDenied
    case unknownError
}

final class UserLocationService: NSObject, CLLocationManagerDelegate {
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()

    var didChangeAuthorizationPermission: ((CLAuthorizationStatus) -> Void)?
    var didUpdateLocation: ((CLLocationCoordinate2D) -> Void)?
    static let shared = UserLocationService()

    override private init() {
        super.init()
    }

    func hasLocationTrackingPermission() -> Bool {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true

        default:
            return false
        }
    }
    
    func getAddressFromLatLon(coordinate: CLLocationCoordinate2D, completion: @escaping(String) -> Void) {
        let ceo: CLGeocoder = CLGeocoder()
        let loc: CLLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        ceo.reverseGeocodeLocation(loc) { (placemarks, error) in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                completion("")
            }
            if let pm = placemarks, pm.count > 0 {
                var addressString: String = ""
                let pm = placemarks![0]
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                completion(addressString)
            }
        }
    }

    func getCurrentLocation() throws -> CLLocationCoordinate2D? {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return locationManager.location?.coordinate

        case .restricted:
            throw UserLocationServiceError.permissionRestricted

        case .denied:
            throw UserLocationServiceError.permissionDenied

        case .authorizedAlways:
            return locationManager.location?.coordinate

        case .authorizedWhenInUse:
            return locationManager.location?.coordinate

        @unknown default:
            throw UserLocationServiceError.unknownError
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        didChangeAuthorizationPermission?(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            didUpdateLocation?(location.coordinate)
        }
        
    }
}

