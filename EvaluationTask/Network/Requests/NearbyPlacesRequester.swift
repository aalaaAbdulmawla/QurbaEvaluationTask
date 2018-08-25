//
//  NearbyPlacesRequester.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

enum NearbyPlacesParamKeys: String {
    case Payload = "payload"
    case Lng = "lng"
    case lat = "lat"
}

struct NearbyPlacesParam {
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    func getParameters() -> [String: AnyObject] {
        var paramList = [String: AnyObject]()
        var location = [String: AnyObject]()
        location[NearbyPlacesParamKeys.Lng.rawValue] = lng as AnyObject
        location[NearbyPlacesParamKeys.lat.rawValue] = lat as AnyObject
        paramList[NearbyPlacesParamKeys.Payload.rawValue] =  location as AnyObject
        return paramList
    }
}

class NearbyPlacesRequester {
    fileprivate let nearbyPlacesEndPoint = "/places/places/nearby?page=1"
    fileprivate let networking: NetworkingInterface
    
    init(networking: NetworkingInterface) {
        self.networking = networking
    }
    
    func requestNearbyPlaces(nearbyPlacesParam: NearbyPlacesParam,
        completionHandler: @escaping (NearbyPlacesEntity) -> ()) {
        let specs = RequestSpecs(method: .POST, URLString: nearbyPlacesEndPoint, parameters: nearbyPlacesParam.getParameters())
        networking.request(specs) { (response, error) -> (Void) in
            let nearbyPlacesDict = response as? [String: AnyObject] ?? [:]
            completionHandler(NearbyPlacesEntity(rawDictionary: nearbyPlacesDict))
        }
    }
}
