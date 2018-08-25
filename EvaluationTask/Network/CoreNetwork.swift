//
//  CoreNetwork.swift
//  Mumzworld
//
//  Created by Eugen Spinu on 1/11/16.
//  Copyright © 2016 Eugen Spinu. All rights reserved.
//

import UIKit

typealias POSTCompletionBlock = (NSError?) -> Void

class CoreNetwork {
    static var sharedInstance = CoreNetwork()

    
    fileprivate lazy var mumzNetworkCommunication: NetworkingInterface = {
        return AlamofireAdaptor(baseURL: HostService.getBaseURL() , headers: EvaluatinTaskServiceSettings().headers)
    }()
    

    func reloadInstances() {
         mumzNetworkCommunication = AlamofireAdaptor(baseURL: HostService.getBaseURL() , headers: EvaluatinTaskServiceSettings().headers)
    }
    
}




