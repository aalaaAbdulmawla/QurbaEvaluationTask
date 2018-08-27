//
//  MapViewScreenViewModel.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/27/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

struct MapViewScreenViewModel {
    let userLocation: Location
    let nearbyPlaces: [CardViewModel]
    var selectedIndex: Int
    
    init(userLocation: Location, nearbyPlaces: [CardViewModel], selectedIndex: Int) {
        self.userLocation = userLocation
        self.nearbyPlaces = nearbyPlaces
        self.selectedIndex = selectedIndex
    }
}
