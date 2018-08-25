//
//  AuthToken.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

enum AuthResponseKeys: String {
    case Reponse = "response"
    case Message = "message"
    case En = "en"
    case Ar = "ar"
    case Debug = "debug"
    case Payload = "payload"
    case Role = "role"
    case Jwt = "jwt"
    case Success = "SUCCESS"
    case Error = "ERROR"
    case Id = "_id"
    case ResponseType = "type"
}

enum ResponseType {
    case Success
    case Error
    
    init(str: String) {
        switch str {
            case AuthResponseKeys.Success.rawValue: self = .Success
            default: self = .Error
        }
    }
}

struct Message {
    let en: String
    let debug: String
    
    init(rawDictionary: [String: AnyObject]) {
        en = rawDictionary[AuthResponseKeys.En.rawValue] as? String ?? ""
        debug = rawDictionary[AuthResponseKeys.Debug.rawValue] as? String ?? ""
    }
}

struct Error {
    let en: String
    let ar: String
    let debug: String
    
    init(rawDictionary: [String: AnyObject]) {
        en = rawDictionary[AuthResponseKeys.En.rawValue] as? String ?? ""
        ar = rawDictionary[AuthResponseKeys.En.rawValue] as? String ?? ""
        debug = rawDictionary[AuthResponseKeys.Debug.rawValue] as? String ?? ""
    }
}


struct Payload {
    let id: String
    let role: String
    let jwt: String
    
    init(rawDictionary: [String: AnyObject]) {
        id = rawDictionary[AuthResponseKeys.Id.rawValue] as? String ?? ""
        role = rawDictionary[AuthResponseKeys.Role.rawValue] as? String ?? ""
        jwt = rawDictionary[AuthResponseKeys.Jwt.rawValue] as? String ?? ""
    }
}

struct AuthTokenResponse {
    let type: ResponseType
    let message: Message
    let payload: Payload?
    let error: Error?
    
    init(rawDictionary: [String: AnyObject]) {
        type = ResponseType(str: rawDictionary[AuthResponseKeys.ResponseType.rawValue] as? String ?? "")
        message = Message(rawDictionary: rawDictionary[AuthResponseKeys.Message.rawValue] as? [String: AnyObject] ?? [:])
        if let rawPayload = rawDictionary[AuthResponseKeys.Payload.rawValue] as? [String: AnyObject] {
            payload = Payload(rawDictionary: rawPayload)
        } else {
            payload = nil
        }
        if let rawError = rawDictionary[AuthResponseKeys.Error.rawValue] as? [String: AnyObject] {
            error = Error(rawDictionary: rawError)
        } else {
            error = nil
        }
    }
}

struct AuthToken {
    let authTokenResponse: AuthTokenResponse
    init(rawDictionary: [String: AnyObject]) {
        authTokenResponse = AuthTokenResponse(rawDictionary: rawDictionary[AuthResponseKeys.Reponse.rawValue] as? [String: AnyObject] ?? [:])
    }
}
