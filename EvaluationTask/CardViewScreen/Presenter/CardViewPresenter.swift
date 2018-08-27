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

class CardViewPresenter: NSObject {
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    fileprivate var firstTimeLoad = false
    fileprivate var cellName =  "CardViewCell"
    private var nearbyLoactions: [CardViewModel]?
    weak fileprivate var viewDelegate: CardViewControllerProtocol?
}

extension CardViewPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0]
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
            print(location.coordinate)
            if (!firstTimeLoad) {
                firstTimeLoad = true
                getNearbyLocations()
            }
        }
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func getNearbyLocations() {
        let param = NearbyPlacesParam(lat: 31.2505866/*location.coordinate.latitude*/, lng: 29.9187387/*location.coordinate.longitude*/)
        viewDelegate?.startActivitityIndicator()
        CoreNetwork.sharedInstance.requestAuthToken() { (authEntity) -> (Void) in
            CoreNetwork.sharedInstance.requestNearbyPlaces(authToken: authEntity.authTokenResponse.payload?.jwt ?? "", nearbyParam: param) { (places) -> (Void) in
                self.viewDelegate?.stopActitvityIndicator()
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
        guard let viewModel = nearbyLoactions?[indexPath.row],
            let cell = viewDelegate?.getTableView().dequeueReusableCell(withIdentifier: cellName,
            for: indexPath) as? CardViewCell else { return UITableViewCell() }
        cell.configureCellWith(viewModel)
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
