//
//  CardViewModel.swift
//  EvaluationTask
//
//  Created by Alaa Abdulmawla on 8/26/18.
//  Copyright © 2018 Alaa Abdulmawla. All rights reserved.
//

import Foundation

enum AvailableNow: String {
    case Open = "Open"
    case Close = "Close"
}

struct CardViewModel {
    let name: String
    let categories: String
    let profileImg: String
    let coverImg: String
    let location: String
    let availability: AvailableNow
    let shortDiscribtion: String
    let hashTags: String
    let facilitiesImgs: [String]
    
    init(nearbyPlaceEntity: PayloadObject) {
        name = nearbyPlaceEntity.name.english
        categories = getJoinedString(arr: nearbyPlaceEntity.categories.map {$0.english}, separator: ", ", prefix: "")
        profileImg = nearbyPlaceEntity.profileImg
        coverImg = nearbyPlaceEntity.coverImg
        location = getLocation(city: nearbyPlaceEntity.address.city.english, area: nearbyPlaceEntity.address.area.english)
        shortDiscribtion = nearbyPlaceEntity.shortDescribtion.english
        hashTags = getJoinedString(arr: nearbyPlaceEntity.hashtages, separator: " ", prefix: "#")
        facilitiesImgs = getFacilitiesImages(facilities: nearbyPlaceEntity.facilities.map { $0.english} )
        availability = isOpen(openingTimes: nearbyPlaceEntity.openingTimes)
    }
}

fileprivate func getJoinedString(arr: [String], separator: String, prefix: String) -> String {
    return arr.map { "\(prefix)\($0)" }.joined(separator: separator)
}

fileprivate func getLocation(city: String, area: String) -> String {
    return "\(area), \(city)"
}

fileprivate let facilitiesImgsDict: [String: String] = [ "Parking" : "ic_parking lots",
                                                     "Non Smoking" : "ic_non smoking area",
                                                       "Open airs" : "ic_outdoors",
                                                            "Wifi" : "ic_wifi"]

fileprivate let Days: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

fileprivate func getFacilitiesImages(facilities: [String]) -> [String] {
    var imgs: [String] = [String]()
    for facility in facilities {
        if let img = facilitiesImgsDict[facility] {
            imgs.append(img)
        }
    }
    return imgs
}

fileprivate func isOpen(openingTimes: OpeningTimes) -> AvailableNow {
    let weekday = Calendar.current.component(.weekday, from: Date()) - 1
    let hour = Calendar.current.component(.hour, from: Date()) //Uses GMT+2 (Egypt) time
    let minute = Calendar.current.component(.minute, from: Date())
    guard let openingDay = openingTimes.days[Days[weekday]], openingDay.isDayOpen else { return .Close }
    for shift in openingDay.shifts {
        if !shift.isShiftOpen { continue }
        if hour >= shift.opens.hour && minute <= shift.closes.hour {
            if (hour == shift.opens.hour && minute < shift.opens.minutes) { continue }
            if (hour == shift.closes.hour && minute < shift.closes.minutes) { continue }
            return .Open
        }
    }
    return .Close
}
