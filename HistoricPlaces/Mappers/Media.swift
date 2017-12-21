//
//  Media.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/15/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import Foundation

import AlamofireObjectMapper
import ObjectMapper

public class Media: Mappable {
    var description: String?
    var url: String?
    var title: String?
    var entityType: String?

    init() {
        
    }
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        description <- map["Description"]
        url <- map["URL"]
        title <- map["Title"]
        entityType <- map["EntityType"]
    }
    
    
}
