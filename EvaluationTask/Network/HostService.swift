//
//  HostService.swift
//  Mumzworld
//
//  Created by Radu Nunu on 2/22/16.
//  Copyright © 2016 Yopeso. All rights reserved.
//

import UIKit

struct HostService {
    static func getBaseURL() -> String {
        return "https://backend-user-alb.qurba-dev.com/"
    }
}

struct EvaluatinTaskServiceSettings {
    let headers: [String: String]
    
    init(requestHeaders: [String : String]) {
        self.headers = requestHeaders
    }
}



