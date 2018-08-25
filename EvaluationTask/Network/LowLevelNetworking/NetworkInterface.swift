//
//  NetworkInterface.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import UIKit

enum RequestMethod: String {
    case GET, POST, PATCH, DELETE
}

enum Encoding {
    case urlEncodedInURL
    case json
}

typealias NetworkingCompletionBlock = (AnyObject?, NSError?) -> (Void)

struct RequestSpecs {
    let method: RequestMethod
    let URLString: String
    let parameters: [String: AnyObject]?
    let encoding: Encoding
    
    init(method: RequestMethod, URLString: String, parameters: [String: AnyObject]?, encoding: Encoding = .urlEncodedInURL) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.encoding = encoding
    }
}

protocol NetworkingInterface {
    func request(_ specs: RequestSpecs, completionBlock: @escaping NetworkingCompletionBlock)
}

