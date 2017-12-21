//
//  Link.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/28/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import Foundation


import AlamofireObjectMapper
import ObjectMapper

class Link : Mappable {
    var entityId: Int
    var description: String?
    var linkType: String?
    var title: String?
    var  entityLinkId: Int
    var  entityType: String?
    var  url: String?
    
    init() {
        entityId = 0
        entityLinkId = 0
    }
    
    required init?(map: Map) {
        entityId = 0
        entityLinkId = 0
    }
    
    func mapping(map: Map) {
        entityId <- map["EntityID"]
        description <- map["Description"]
        linkType <- map["LinkType"]
        title <- map["Title"]
        entityLinkId <- map["EntityLinkID"]
        entityType <- map["EntityType"]
        url <- map["URL"]
    }
    
}

