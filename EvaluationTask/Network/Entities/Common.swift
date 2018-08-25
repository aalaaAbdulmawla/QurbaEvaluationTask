//
//  Common.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

enum CommonResponseKeys: String {
    case Response = "response"
    case ResponseType = "type"
    case Message = "message"
    case Payload = "payload"
    case En = "en"
    case Ar = "ar"
    case Success = "SUCCESS"
    case Error = "ERROR"
    case Debug = "debug"
}

struct LocalizationStrings {
    let arabic: String
    let english: String
    
    init(rawDictionary: [String: AnyObject]) {
        english = rawDictionary[CommonResponseKeys.En.rawValue] as? String ?? ""
        arabic = rawDictionary[CommonResponseKeys.Ar.rawValue] as? String ?? ""
    }
}

enum ResponseType {
    case Success
    case Error
    
    init(str: String) {
        switch str {
            case CommonResponseKeys.Success.rawValue: self = .Success
            default: self = .Error
        }
    }
}

struct Message {
    let language: LocalizationStrings
    let debug: String
    
    init(rawDictionary: [String: AnyObject]) {
        language = LocalizationStrings(rawDictionary: rawDictionary)
        debug = rawDictionary[CommonResponseKeys.Debug.rawValue] as? String ?? ""
    }
}

struct Error {
    let language: LocalizationStrings
    let debug: String
    
    init(rawDictionary: [String: AnyObject]) {
        language = LocalizationStrings(rawDictionary: rawDictionary)
        debug = rawDictionary[CommonResponseKeys.Debug.rawValue] as? String ?? ""
    }
}


