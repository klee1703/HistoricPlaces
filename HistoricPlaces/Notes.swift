//
//  Notes.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/28/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import Foundation

class Notes {
    static var instance: Notes?

    var data: [String:PlaceNote]

    init() {
        data = [:]
    }
    
    static func INSTANCE() -> Notes? {
        if nil == instance {
            instance = Notes()
        }
        return instance
    }
}
