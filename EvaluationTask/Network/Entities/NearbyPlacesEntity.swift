//
//  NearbyPlaces.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

struct Location {
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    init(rawArray: [Double]) {
        if rawArray.count == 2 {
            lng = rawArray[0]
            lat = rawArray[1]
        }
    }
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}

struct Period {
    let hour: Int
    let minutes: Int
    
    init(rawDictionary: [String: AnyObject]) {
        hour = rawDictionary[OpeningTimesKeys.Hour] as? Int ?? 0
        minutes = rawDictionary[OpeningTimesKeys.Minutes] as? Int ?? 0
    }
}

struct Shift {
    let opens: Period
    let closes: Period
    let isShiftOpen: Bool
    
    init(rawDictionary: [String: AnyObject]) {
        opens = Period(rawDictionary: rawDictionary[OpeningTimesKeys.Opens] as? [String: AnyObject] ?? [:])
        closes = Period(rawDictionary: rawDictionary[OpeningTimesKeys.Closes] as? [String: AnyObject] ?? [:])
        isShiftOpen = rawDictionary[OpeningTimesKeys.IsShiftOpen] as? Bool ?? false
    }
}

struct Day {
    var shifts: [Shift] = []
    let isDayOpen: Bool
    
    init(rawDictionary: [String: AnyObject]) {
        let rawShifts = rawDictionary[OpeningTimesKeys.Shifts] as? [AnyObject]
        shifts = (rawShifts?.map { Shift(rawDictionary: ($0 as? [String: AnyObject] ?? [:]) ) }) ?? []
        isDayOpen = rawDictionary[OpeningTimesKeys.IsDayOpen] as? Bool ?? false
    }
    
}

struct OpeningTimes {
    var days: [String: Day] = [:]
    
    init(rawDictionary: [String: AnyObject]) {
        for day in OpeningTimesKeys.Days {
            days[day] = Day(rawDictionary: rawDictionary[day] as? [String: AnyObject] ?? [:])
        }
    }
}

struct Address {
    var city: LocalizationStrings = LocalizationStrings(rawDictionary: [:])
    var area: LocalizationStrings = LocalizationStrings(rawDictionary: [:])
    
    init(rawDictionary: [String: AnyObject]) {
        if let rawCity = rawDictionary[AddressKeys.City.rawValue] as? [String: AnyObject],
            let rawName = rawCity[AddressKeys.Name.rawValue] as? [String: AnyObject] {
            city = LocalizationStrings(rawDictionary: rawName)
        }
        if let rawArea = rawDictionary[AddressKeys.Area.rawValue] as? [String: AnyObject],
            let rawName = rawArea[AddressKeys.Name.rawValue] as? [String: AnyObject] {
            area = LocalizationStrings(rawDictionary: rawName)
        }
    }
}


struct PayloadObject {
    let name: LocalizationStrings
    let address: Address
    let userFollowersCount: Int
    let openingTimes: OpeningTimes
    let facilities: [LocalizationStrings]
    let hashtages: [String]
    let shortDescribtion: LocalizationStrings
    let profileImg: String
    let coverImg: String
    let categories: [LocalizationStrings]
    let location: Location
    
    init(rawDictionary: [String: AnyObject]) {
        name = LocalizationStrings(rawDictionary: rawDictionary[PayloadObjectKeys.Name.rawValue] as? [String: AnyObject] ?? [:])
        address = Address(rawDictionary: rawDictionary[PayloadObjectKeys.Address.rawValue] as? [String: AnyObject] ?? [:])
        userFollowersCount = rawDictionary[PayloadObjectKeys.UserFollowersCount.rawValue] as? Int ?? 0
        openingTimes = OpeningTimes(rawDictionary: rawDictionary[PayloadObjectKeys.OpeningTimes.rawValue] as? [String: AnyObject] ?? [:])
        let rawFacilities = rawDictionary[PayloadObjectKeys.Facilities.rawValue] as? [[String: AnyObject]] ?? [[:]]
        facilities = rawFacilities.map { LocalizationStrings(rawDictionary: $0[PayloadObjectKeys.Name.rawValue] as? [String: AnyObject] ?? [:]) }
        let rawHashtags = rawDictionary[PayloadObjectKeys.Hashtags.rawValue] as? [[String : AnyObject]] ?? [[:]]
        hashtages = rawHashtags.map { ($0[PayloadObjectKeys.Name.rawValue] as? String) ?? "" }
        shortDescribtion = LocalizationStrings(rawDictionary: rawDictionary[PayloadObjectKeys.ShortDescription.rawValue] as? [String: AnyObject] ?? [:])
        profileImg = rawDictionary[PayloadObjectKeys.PlaceProfilePictureUrl.rawValue] as? String ?? ""
        coverImg = rawDictionary[PayloadObjectKeys.PlaceProfileCoverPictureUrl.rawValue] as? String ?? ""
        let rawCategories = rawDictionary[PayloadObjectKeys.Categories.rawValue] as? [[String: AnyObject]] ?? [[:]]
        let rawCategoriesNames = rawCategories.map { $0[PayloadObjectKeys.Name.rawValue] as? [String: AnyObject] ?? [:]}
        categories = rawCategoriesNames.map { LocalizationStrings(rawDictionary: $0) }
        let rawLocation = rawDictionary[PayloadObjectKeys.Location.rawValue] as? [String: AnyObject] ?? [:]
        location = Location(rawArray: rawLocation[LocationsKeys.Coordinates.rawValue] as? [Double] ?? [])
    }
}

struct NearbyPlacesResponse {
    let type: ResponseType
    let message: Message
    var error: Error? = nil
    var payLoad: [PayloadObject]? = nil
    
    init (rawDictionary: [String: AnyObject]) {
        type = ResponseType(str: rawDictionary[CommonResponseKeys.ResponseType.rawValue] as? String ?? "")
        message = Message(rawDictionary: rawDictionary[CommonResponseKeys.Message.rawValue] as? [String: AnyObject] ?? [:])
        if let rawError = rawDictionary[CommonResponseKeys.Error.rawValue] as? [String: AnyObject] {
            error = Error(rawDictionary: rawError)
        }
        if let rawPayload = rawDictionary[CommonResponseKeys.Payload.rawValue] as? [[String : AnyObject]] {
            payLoad = rawPayload.map { PayloadObject(rawDictionary: $0) }
        }
    }
}

struct NearbyPlacesEntity {
    let nearbyPlacesResponse: NearbyPlacesResponse
    init(rawDictionary: [String: AnyObject]) {
        nearbyPlacesResponse = NearbyPlacesResponse(rawDictionary: rawDictionary[CommonResponseKeys.Response.rawValue] as?
            [String: AnyObject] ?? [:])
    }
}
