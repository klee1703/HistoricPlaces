//
//  Constants.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/15/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit

struct Constants {
    // Titles for error alerts
    static let kErrorRetrievingDataTitle = "Error Retrieving Data"
    static let kOrganizationID = "143"
    static let kApiKey = "C61DDD8C1AB947E4AE2D6C815A8DCF55"
    static let kOrgBaseUrl = "https://ridb.recreation.gov/api/v1/organizations/"
    static let kOrgUrl = "https://ridb.recreation.gov/api/v1/organizations/143/facilities.json?&limit=100&apikey=C61DDD8C1AB947E4AE2D6C815A8DCF55"
    static let kDefaultHotelUrl = "http://www.historichotels.org/"
    static let kDefaultEmailAddress = "HistoricHotelsofAmerica@HistoricHotels.org"
    static let kDefaultPhoneNumber = "800-678-8946"
    static let kHotelResortsUrlSegment = "hotels-resorts/"
    static let kPlaceNotesType = "PlaceNotesType"
    static let kPlaceNameField = "placeName"
    static let kPlaceNoteField = "placeNote"
    static let kAccountLoginTitle = "Sign in to iCloud"
    static let kAccountLoginMessage = "Sign in to your iCloud account to access all of the app's features. On the Home screen, launch Settings, tap iCloud, and enter your Apple ID. Turn iCloud Drive on. If you don't have an iCloud account, tap Create a new Apple ID."
    static let kNetworkDownTitle = "Cellular Data is Turned Off"
    static let kNetworkDownMessage = "Turn on cellular data or use Wi-Fi to access data."

    static func getStandardAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        return alert
    }
}

