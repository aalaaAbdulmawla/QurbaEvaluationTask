//
//  NSError+Networking.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

extension NSError {
    func appendErrorData(_ data: Data?) -> NSError {
        guard let unwrappedData = data else { return self }
        do {
            let serializedData = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments)
            let userInfoDict = serializedData as? [AnyHashable: Any]
            return NSError(domain: domain, code: code, userInfo: userInfoDict as? [String : Any])
        } catch {
            return self
        }
    }
    
    var title: String? {
        return  self.userInfo["title"] as? String
    }
    var detail: String? {
        guard let details = self.userInfo["detail"] as? String else {
            return self.localizedDescription
        }
        return details
    }
    var status: Int? {
        return  self.userInfo["status"] as? Int
    }
}

