//
//  CloudDBManager.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/30/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit
import CloudKit

public class CloudDBManager {
    var delegate: ModelDelegate?
    var viewController: UIViewController

    static var instance: CloudDBManager?
    
    static func INSTANCE(viewController: UIViewController) -> CloudDBManager? {
        if nil == instance {
            instance = CloudDBManager(viewController: viewController)
        }
        return instance
    }

    /**
     * Constructor for initializing the GameCenterManager
     */
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func getNotes() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "PlaceNotesType", predicate: predicate)
        let publicDB = CKContainer.default().publicCloudDatabase
        publicDB.perform(query, inZoneWith: nil) {results, error in
            if error == nil {
                // process
                for record in results! {
                    let placeNote = PlaceNote(record: record, database: publicDB)
                    Notes.INSTANCE()?.data[placeNote.placeName] = placeNote
                }
            }
            else {
                DispatchQueue.main.async {
                    self.delegate?.errorUpdating(error! as NSError)
                }
                return
            }
        }
        // Successfully retrieved records, perform processing
        DispatchQueue.main.async {
            self.delegate?.modelUpdated()
        }
    }

    // MARK: - Cloud DB updates
    
    func errorUpdating(_ error: NSError) {
        let alert = getStandardAlert(title: "Notes Query", message: "Error performing query")
        viewController.present(alert, animated:true, completion:nil)
    }
    func modelUpdated() {
    }
    
    func getStandardAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        return alert
    }
}
