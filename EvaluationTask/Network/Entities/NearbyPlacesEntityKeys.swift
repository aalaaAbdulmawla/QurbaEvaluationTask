//
//  NearbyPlacesEntityKeys.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/25/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

enum PayloadObjectKeys: String {
    case Name = "name"
    case Address = "address"
    case UserFollowersCount = "userFollowersCount"
    case OpeningTimes = "openingTimes"
    case Facilities = "facilities"
    case Hashtags = "hashtags"
    case Location = "location"
    case ShortDescription = "shortDescription"
    case PlaceProfilePictureUrl = "placeProfilePictureUrl"
    case Categories = "categories"
    case PlaceProfileCoverPictureUrl = "placeProfileCoverPictureUrl"
}

enum AddressKeys: String {
    case City = "city"
    case Area = "area"
    case Name = "name"
}

enum LocationsKeys: String {
    case LocationType = "type"
    case Coordinates = "coordinates"
}

struct OpeningTimesKeys {
    static let Days: [String] = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    static let Shifts = "shifts"
    static let Opens = "opens"
    static let Closes = "closes"
    static let IsShiftOpen = "isShiftOpen"
    static let IsDayOpen = "isDayOpen"
    static let Hour = "hour"
    static let Minutes = "minutes"
}
