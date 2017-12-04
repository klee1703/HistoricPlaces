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
    static let kOrgUrl = "https://ridb.recreation.gov/api/v1/organizations/143/facilities.json?full=true&apikey=C61DDD8C1AB947E4AE2D6C815A8DCF55"
    static let kDefaultHotelUrl = "http://www.historichotels.org/"
    static let kHotelResortsUrlSegment = "hotels-resorts/"
    static let kPlaceNotesType = "PlaceNotesType"
    static let kPlaceNameField = "placeName"
    static let kPlaceNoteField = "placeNote"

    static func getStandardAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        return alert
    }
}

