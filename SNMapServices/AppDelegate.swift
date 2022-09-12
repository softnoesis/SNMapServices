//
//  AppDelegate.swift
//  SNMapServices
//
//  Created by iChirag on 10/09/22.
//  Copyright © 2022 Softnoesis. All rights reserved.
//

import UIKit
import GoogleMaps

// MARK: - Delegate
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Did finish launching")
        
        GMSServices.provideAPIKey("YOUR_API_KEY")
        return true
    }
}
