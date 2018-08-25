//
//  AuthToken.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

enum AuthResponseKeys: String {
    case Role = "role"
    case Jwt = "jwt"
    case Id = "_id"
}

struct AuthTokenPayload {
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
    var payload: AuthTokenPayload? = nil
    var error: Error? = nil
    
    init(rawDictionary: [String: AnyObject]) {
        type = ResponseType(str: rawDictionary[CommonResponseKeys.ResponseType.rawValue] as? String ?? "")
        message = Message(rawDictionary: rawDictionary[CommonResponseKeys.Message.rawValue] as? [String: AnyObject] ?? [:])
        if let rawPayload = rawDictionary[CommonResponseKeys.Payload.rawValue] as? [String: AnyObject] {
            payload = AuthTokenPayload(rawDictionary: rawPayload)
        }
        if let rawError = rawDictionary[CommonResponseKeys.Error.rawValue] as? [String: AnyObject] {
            error = Error(rawDictionary: rawError)
        }
    }
}

struct AuthTokenEntity {
    let authTokenResponse: AuthTokenResponse
    init(rawDictionary: [String: AnyObject]) {
        authTokenResponse = AuthTokenResponse(rawDictionary: rawDictionary[CommonResponseKeys.Response.rawValue] as?
            [String: AnyObject] ?? [:])
    }
}
