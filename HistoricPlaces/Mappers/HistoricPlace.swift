//
//  FacilityDescription.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/15/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import Foundation

import AlamofireObjectMapper
import ObjectMapper

class HistoricPlace : Mappable {
    var description: String?
    var useFeeDescription: String?
    var longitude: Double
    var latitude: Double
    var email: String?
    var address: [Address]?
    var name: String?
    var directions: String?
    var phone: String?
    var media: [Media]?
    var placeUrl: String?
    var links: [Link]?

    required init?(map: Map) {
        longitude = 0.0
        latitude = 0.0
        address = []
        media = []
        links = []
    }

    init() {
        longitude = 0.0
        latitude = 0.0
        address = []
        media = []
        links = []
   }

    func mapping(map: Map) {
        description <- map["FacilityDescription"]
        useFeeDescription <- map["FacilityUseFeeDescription"]
        media <- map["MEDIA"]
        links <- map["LINK"]
        email <- map["FacilityEmail"]
        longitude <- map["FacilityLongitude"]
        latitude <- map["FacilityLatitude"]
        address <- map["FACILITYADDRESS"]
        name <- map["FacilityName"]
        directions <- map["FacilityDirections"]
        phone <- map["FacilityPhone"]
    }
}
