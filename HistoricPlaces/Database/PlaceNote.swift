//
//  PlaceNote.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/30/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import Foundation
import CloudKit


class PlaceNote: NSObject {
    
    // MARK: - Properties
    var record: CKRecord!
    var placeName: String!
    var placeNote: String!
    weak var database: CKDatabase!
    var assetCount = 0

    // MARK: - Initializers
    init(record: CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        
        self.placeName = record["placeName"] as? String
        self.placeNote = record["placeNote"] as? String
    }
}
