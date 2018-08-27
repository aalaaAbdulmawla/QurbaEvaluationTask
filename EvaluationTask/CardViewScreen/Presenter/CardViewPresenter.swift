//
//  CardViewPresenter.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/27/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol CardViewPresenterProtocol: class {
    func viewDidLoad()
    func getNumberOfRows() -> Int
    func getCellForRowAtIndex(_ index: IndexPath) -> UITableViewCell
    func didSelectRowAtndex(_ index: Int)
    func seViewtDelegate(delegate: CardViewControllerProtocol)
}

class CardViewPresenter: NSObject {
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    fileprivate var flag = false
    private var nearbyLoactions: [CardViewModel]?
    weak fileprivate var viewDelegate: CardViewControllerProtocol?
}

extension CardViewPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0]
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            print(location.coordinate)
            if (!flag) {
                flag = true
                getNearbyLocations()
            }
        }
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func getNearbyLocations() {
        let param = NearbyPlacesParam(lat: 31.2505866/*location.coordinate.latitude*/, lng: 29.9187387/*location.coordinate.longitude*/)
        CoreNetwork.sharedInstance.requestAuthToken() { (authEntity) -> (Void) in
            CoreNetwork.sharedInstance.requestNearbyPlaces(authToken: authEntity.authTokenResponse.payload?.jwt ?? "", nearbyParam: param) { (places) -> (Void) in
                print(places)
                self.nearbyLoactions = places.nearbyPlacesResponse.payLoad?.map { CardViewModel(nearbyPlaceEntity: $0 )}
                self.viewDelegate?.reloadData()
            }
        }
    }
}

extension CardViewPresenter: CardViewPresenterProtocol {
    func seViewtDelegate(delegate: CardViewControllerProtocol) {
        self.viewDelegate = delegate
    }
    
    func getNumberOfRows() -> Int {
        return nearbyLoactions?.count ?? 0
    }
    
    func getCellForRowAtIndex(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = viewDelegate?.getTableView().dequeueReusableCell(withIdentifier: "CardViewCell",
            for: indexPath) as! CardViewCell
        //let viewModel = nearbyLoactions?[indexPath.row] else { return UITableViewCell() }
        cell.configureCellWith(nearbyLoactions![indexPath.row])
        cell.selectionStyle = .default
        return cell
    }
    
    func didSelectRowAtndex(_ index: Int) {
        
    }
    
    func viewDidLoad() {
       setUpLocationTracker()
    }
    
    private func setUpLocationTracker() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }
}
