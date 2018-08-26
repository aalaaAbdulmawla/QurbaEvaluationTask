//
//  ViewController.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/23/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit
import CoreLocation

class CardViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0] 
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            
            /* do something with coordinates */
            print(location.coordinate)
            if (!flag) {
                let param = NearbyPlacesParam(lat: 29.9187387/*location.coordinate.latitude*/, lng: 31.2505866/*location.coordinate.longitude*/)
                
                CoreNetwork.sharedInstance.requestAuthToken() { (authEntity) -> (Void) in
                    CoreNetwork.sharedInstance.requestNearbyPlaces(authToken: authEntity.authTokenResponse.payload?.jwt ?? "", nearbyParam: param) { (nearbyPlaces) -> (Void) in
                        print(nearbyPlaces)
                    }
                }
                flag = true
            }
        }
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}
