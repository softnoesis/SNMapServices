# SNMapServices
SNMapServices is a serices for iOS written in SwiftUI. It provides Map capability by subclassing Mapbox, Google map and Apple map.
This Service is an easy to use drawer library meant to imitate the drawer in iOS 14/15's Maps app. It exposes a simple class that allows you to use any SwiftUI view subclass as the drawer content or the primary content.

## Usages 🔥
This service can be comparable for Apple, Google and Mapbox map. It will useful for tracking user location, adding annotation pin on map, customize annotation views and user current location view, handle annotation's click and also change map style, type and their regions behaviour.

## Language 
* SwiftUI

## Requirements 📝
* Swift 5.0+
* iOS 14.0+
* Xcode 12+

## Preview 
<img src="https://github.com/iChirag/SNMapServices/blob/main/Preview/apple.gif" width="200" height="400" /> <img src="https://github.com/iChirag/SNMapServices/blob/main/Preview/mapbox.gif" width="200" height="400" /> <img src="https://github.com/iChirag/SNMapServices/blob/main/Preview/google.gif" width="200" height="400" />

## Setup Manager
To install in project first you need to drag and drop the sources folder into your project. 

### Apple Map 
Set region of current map, number annotation, map type(standard, satellite, hybrid), user tracking mode and user location.
```
    @Published var region: MKCoordinateRegion
    @Published var pins: [AnnotationPin] = [.t1, .t2, .t3, .t4]
    
    var mapType: MKMapType = .standard
    var userTrackingMode: MKUserTrackingMode = .follow
    var showUserLocation = true
    
    var body: some View { 
      SNAppleMapView(region: region, 
                     pin: pins, 
                     mapType: mapType, 
                     userTrackingMode: userTrackingMode, 
                     showsUserLocation: showUserLocation) { annotation in
                           <#code#>
                          // Handle here annotation tapped
                   }
    }
```


### Google Map
Setup Google map console [Google Map Documentation](https://developers.google.com/maps/documentation/ios-sdk/config)
```
GMSServices.provideAPIKey("YOUR_API_KEY")
```

Set current visible region location, annotations pins, user location enable and maps type.
```
    @StateObject var currentLocation: CLLocationCoordinate2D
    @StateObject var pins: [AnnotationPin] = [.t1, .t2, .t3, .t4]
    
    var mapType: GMSMapViewType = .normal
    var isShowCurrentLocation = true
    
    var body: some View {
      SNGoogleMapView(currentRegionCenterLocation: $currentLocation,
                      pins: $pins,
                      isMyLocationEnabled: isShowCurrentLocation,
                      mapType: mapType) { location in
                         <#code#>
                         // Handle here annotation tapped
                    }
     }
```

### Mapbox Map
Setup Mapbox [Mapbox Documentation](https://docs.mapbox.com/ios/maps/guides/) 
```
pod 'Mapbox-iOS-SDK'
```

```
<key>MGLMapboxAccessToken</key>
	<string>YOUR_MAPBOX_ACCRSS_TOKEN</string>
```
Set current visible region location, annotations pins, user location enable and User tracking mode.
```
    @StateObject var currentLocation: CLLocationCoordinate2D
    @StateObject var pins: [AnnotationPin] = [.t1, .t2, .t3, .t4]
    
    var isShowCurrentLocation = true
    var userTrackingMode: MGLUserTrackingMode = .follow
    
    var body: some View {
        SNMapBoxView(currentRegionCenterLocation: $currentLocation,
                     pins: $pins,
                     userTrackingMode: userTrackingMode,
                     isShowCurrentLocation: isShowCurrentLocation) { annotation in
                     
                     <#code#>
                     // Handle here annotation tapped
                    }
    }
```

## Contact Us
For any query feel free to connect at [contact@softnoesis.com](mailto:contact@softnoesis.com).
