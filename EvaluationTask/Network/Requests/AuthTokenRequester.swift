//
//  AuthTokenRequester.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

enum AuthTokenParamKeys: String {
    case Payload = "payload"
    case DeviceId = "deviceId"
}

struct AuthTokenParam {
    let deviceId: String = "123456"

    func getParameters() -> [String: AnyObject] {
        var paramList = [String: AnyObject]()
        var payloadObject = [String: AnyObject]()
        payloadObject[AuthTokenParamKeys.DeviceId.rawValue] = deviceId as AnyObject
        paramList[NearbyPlacesParamKeys.Payload.rawValue] =  payloadObject as AnyObject
        return paramList
    }
}

class AuthTokenRequester {
    fileprivate let authTokenEndpoint = "/places/places/nearby"
    fileprivate let networking: NetworkingInterface
    
    init(networking: NetworkingInterface) {
        self.networking = networking
    }
    
    func requestAuthToken(_ authTokenParam: AuthTokenParam, completionHandler: @escaping (AuthTokenEntity) -> ()) {
        let specs = RequestSpecs(method: .POST, URLString: authTokenEndpoint, parameters: authTokenParam.getParameters())
        networking.request(specs) { (response, error) -> (Void) in
            let authTokenDict = response as? [String: AnyObject] ?? [:]
            completionHandler(AuthTokenEntity(rawDictionary: authTokenDict))
        }
    }
}

