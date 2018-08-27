//
//  MapViewScreenPresenter.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/27/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapViewScreenPresenter {
    fileprivate let viewModel: MapViewScreenViewModel
    fileprivate var mapView: GMSMapView?
    weak var viewDelegate: MapViewProtocol?
    
    init(userLocation: Location, cardViewModels: [CardViewModel], selectedIndex: Int) {
        self.viewModel = MapViewScreenViewModel(userLocation: userLocation, nearbyPlaces: cardViewModels,
            selectedIndex: selectedIndex)
    }
    
}

extension MapViewScreenPresenter: MapViewScreenPresenterProtocol {
    func viewDidLoad() {
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.userLocation.lat, longitude: viewModel.userLocation.lng, zoom: 12.5)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        setMarkers()
        viewDelegate?.setView(mapView: mapView)
    }
 
    private func setMarkers() {
        for (index, place) in viewModel.nearbyPlaces.enumerated() {
            let marker = GMSMarker()
            let location =  CLLocationCoordinate2D(latitude: place.locationCoordinates.lat,
                                                   longitude: place.locationCoordinates.lng)
            marker.position = location
            marker.title = place.name
            marker.map = mapView
            if index == viewModel.selectedIndex {
                updateSelectedLocation(location: location, marker: marker)
            }
        }
    }
    
    private func updateSelectedLocation(location: CLLocationCoordinate2D, marker: GMSMarker) {
        mapView?.selectedMarker = marker
        mapView?.animate(toLocation: location)
    }
}
