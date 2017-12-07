//
//  NotesViewController.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/28/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit
import CloudKit

// Specify the protocol to be used by view controllers to handle notifications.
protocol ModelDelegate {
    func errorUpdating(_ error: NSError)
    func modelUpdated()
}

class NotesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var notesView: UITextView!
    
    // MARK: - Actions
    @IBAction func clearNotes(_ sender: UIBarButtonItem) {
        notesView.text = ""
    }

    // MARK: - Local Variables
    var place: HistoricPlace?


    // MARK: - Standard methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        notesView.layer.borderColor = UIColor.black.cgColor
        notesView.layer.borderWidth = 2.0;
        notesView.layer.cornerRadius = 5.0;
        getNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Save notes in dictionary
        if let name = place?.name {
            saveNote(name: name, note: notesView.text)
        }
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: - iCloud Record Operations (CRUD)

    func getNotes() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.kPlaceNotesType, predicate: predicate)
        let publicDB = CKContainer.default().publicCloudDatabase
        publicDB.perform(query, inZoneWith: nil) { results, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorUpdating(title: "Query Record", error: error as NSError)
                }
            } else {
                // Successfully retrieved records, perform processing
                for record in results! {
                    let placeNote = PlaceNote(record: record, database: publicDB)
                    placeNote.placeName = record[Constants.kPlaceNameField] as! String
                    placeNote.placeNote = record[Constants.kPlaceNoteField] as! String
                    if self.place?.name?.lowercased() == placeNote.placeName.lowercased() {
                        Notes.INSTANCE()?.data[placeNote.placeName] = placeNote
                        DispatchQueue.main.async {
                            // process results of query
                            self.queryNote(name: placeNote.placeName, note: placeNote.placeNote)
                        }
                    }
                }
            }
        }
    }

    func queryNote(name: String, note: String) {
        // Update note text accordingly
        self.notesView.text = note
    }

    func saveNote(name: String, note: String) {
        let placeNotes = Notes.INSTANCE()?.data
        if nil == placeNotes![name] {
            // Record doesn't exist in data, add it
            createNote(name: name, note: note)
        } else {
            // Record in database, save note
            if let record = placeNotes![name]?.record {
                updateNote(record: record, name: name, note: note)
            }
        }
    }
    
    func updateNote(record: CKRecord, name: String, note: String) {
        // record with this username, update this one!
        let publicDB = CKContainer.default().publicCloudDatabase
        record[Constants.kPlaceNameField] = name as CKRecordValue
        record[Constants.kPlaceNoteField] = note as CKRecordValue
        
        let modifyRecordsOperation = CKModifyRecordsOperation()
        let ckRecordsArray = [record]
        modifyRecordsOperation.recordsToSave = ckRecordsArray as [CKRecord]
        modifyRecordsOperation.savePolicy = .allKeys
        modifyRecordsOperation.qualityOfService = .userInitiated
        modifyRecordsOperation.modifyRecordsCompletionBlock = { saveRecords, deletedRecordIDs, error in
            if let error = error {
                self.errorUpdating(title: "Updating Record", error: error as NSError)
            } else {
                DispatchQueue.main.async {
                    self.modelUpdated(name: name, note: note)
                }
            }
        }
        publicDB.add(modifyRecordsOperation)
    }
    
    func createNote(name: String, note: String)  {
        let publicDB = CKContainer.default().publicCloudDatabase
        let record = CKRecord(recordType: Constants.kPlaceNotesType)
        record[Constants.kPlaceNameField] = name as CKRecordValue
        record[Constants.kPlaceNoteField] = note as CKRecordValue
        publicDB.save(record) { results, error in
            if let error = error {
                self.errorUpdating(title: "Creating Record", error: error as NSError)
            } else {
                DispatchQueue.main.async {
                    self.modelCreated(name: name, note: note)
                }
            }
        }
    }

    // MARK: - Process Cloud DB updates
    
    func errorUpdating(title: String, error: NSError) {
        let alert = Constants.getStandardAlert(title: title, message: "Error: \(error.localizedDescription)")
        self.present(alert, animated:true, completion:nil)
    }
    
    func modelUpdated(name: String, note: String) {
        // Record updated, now update notes text!
        self.notesView.text = note
    }
    
    func modelCreated(name: String, note: String) {
        // Record created, now update notes text
        self.notesView.text = note
    }
}
