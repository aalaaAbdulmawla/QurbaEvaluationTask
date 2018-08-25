//
//  ConnectionObserver.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit
import Alamofire

class ConnectionObserver {
    static let sharedInstance = ConnectionObserver()
    fileprivate var reachabilityManager: NetworkReachabilityManager?
    
    init() {
        reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.mumzworld.com")
        listenForReachability()
    }
    
    func listenForReachability() {
        self.reachabilityManager?.listener = { status in
            if status == .notReachable { return }
        }
        self.reachabilityManager?.startListening()
    }
    
    func isInternetConnection() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    func checkConnection(_ requestData: RequestData) -> Bool {
        if isInternetConnection() { return true }
        HUDAnimationService.hideProgressHUDWith(nil)
        ConnectionStatus.presentController(requestData)
        return false
    }
}
