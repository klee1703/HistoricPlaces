//
//  Address.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/9/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import Foundation

import AlamofireObjectMapper
import ObjectMapper

class Address: Mappable {
    var streetAddress1: String?
    var streetAddress2: String?
    var streetAddress3: String?
    var city: String?
    var stateCode: String?
    var countryCode: String?
    var postalCode: Int
    
    required init?(map: Map) {
        postalCode = 0
    }
    
    init() {
        postalCode = 0
    }
    
    func mapping(map: Map) {
        postalCode <- map["PostalCode"]
        city <- map["City"]
        streetAddress1 <- map["FacilityStreetAddress1"]
        streetAddress2 <- map["FacilityStreetAddress2"]
        streetAddress3 <- map["FacilityStreetAddress3"]
        stateCode <- map["AddressStateCode"]
        countryCode <- map["AddressCountryCode"]
    }
}
