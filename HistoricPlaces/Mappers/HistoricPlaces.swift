//
//  HistoricPlaces.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/15/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import Foundation

import AlamofireObjectMapper
import ObjectMapper

class HistoricPlaces : Mappable {
    var places: [HistoricPlace]?
    
    required init?(map: Map) {
        places = []
    }
    
    func mapping(map: Map) {
        places <- map["RECDATA"]
    }
    
}
