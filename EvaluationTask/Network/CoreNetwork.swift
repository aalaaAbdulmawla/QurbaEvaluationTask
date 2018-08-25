//
//  CoreNetwork.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit

typealias POSTCompletionBlock = (NSError?) -> Void

class CoreNetwork {
    static var sharedInstance = CoreNetwork()

    fileprivate func networkCommunication(headres: [String : String]) -> NetworkingInterface {
        return AlamofireAdaptor(baseURL: HostService.getBaseURL() , headers: headres)
    }
}

extension CoreNetwork {
    func requestAuthToken(_ completionHandler: @escaping ((AuthTokenEntity)) -> ()) {
        let network = networkCommunication(headres: [:])
        let requester = AuthTokenRequester(networking: network)
        let authTokenParam = AuthTokenParam()
        requester.requestAuthToken(authTokenParam, completionHandler: completionHandler)
    }
}

extension CoreNetwork {
    func requestNearbyPlaces(authToken: String, nearbyParam: NearbyPlacesParam, completionHandler: @escaping ((NearbyPlacesEntity)) -> ()) {
        let headers = EvaluatinTaskServiceSettings(authToken: authToken)
        let network = networkCommunication(headres: headers.headers)
        let requester = NearbyPlacesRequester(networking: network)
        requester.requestNearbyPlaces(nearbyPlacesParam: nearbyParam, completionHandler: completionHandler)
    }
}



