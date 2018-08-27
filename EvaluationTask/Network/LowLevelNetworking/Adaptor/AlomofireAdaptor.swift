//
//  AlomofireAdaptor.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation


import Alamofire

class AlamofireAdaptor: NetworkingInterface {
    let requestBaseURL: String
    let requestHeaders: [String: String]?
    let minValidStatusCode = 200
    let maxValidStatusCode = 403
    let AlamofireBugErrorCode = 3840
    let validContentTypes = ["application/json"]
    let backgroundQueue = DispatchQueue(label: "com.task.requests", qos: .userInteractive)
    
    init(baseURL: String , headers: [String: String]? = nil) {
        self.requestBaseURL = baseURL
        self.requestHeaders = headers
    }

    func request(_ specs: RequestSpecs, completionBlock: @escaping NetworkingCompletionBlock) {
        let url = requestBaseURL + specs.URLString
        let encoding = convertRequestEnconding(specs.encoding)
        let request = Alamofire.request(url, method: convertRequestMethodToAlamofireMethod(specs.method), parameters: specs.parameters, encoding: encoding, headers: requestHeaders)
            .validate(statusCode: minValidStatusCode..<maxValidStatusCode)
            .validate(contentType: validContentTypes)
        backgroundQueue.async {
            request.responseJSON() { response in
                if let requestURL = response.request?.url?.absoluteString {
                    print("Request - \(requestURL)")
                }
                let error = response.result.error
                if error?._code == self.AlamofireBugErrorCode { completionBlock(response.result.value as AnyObject, nil); return }
                completionBlock(response.result.value as AnyObject, (error as NSError?)?.appendErrorData(response.data))
            }
        }

    }
    
    func convertRequestEnconding(_ enconding: Encoding) -> ParameterEncoding {
        switch enconding {
        case .json:
            return JSONEncoding.default
        case.urlEncodedInURL:
            return URLEncoding.default
        }
    }
    
    func convertRequestMethodToAlamofireMethod(_ method: RequestMethod) -> Alamofire.HTTPMethod {
        switch method {
        case .DELETE :
            return HTTPMethod.delete
        case .GET :
            return HTTPMethod.get
        case .PATCH :
            return HTTPMethod.patch
        case .POST :
            return HTTPMethod.post
        }
    }
    
}
