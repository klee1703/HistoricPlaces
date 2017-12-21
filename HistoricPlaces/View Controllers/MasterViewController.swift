//
//  MasterViewController.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/7/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import  CloudKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var places = [HistoricPlace]()
    var parameters: [String: Any] = [:]
    var httpHeaders: [String: String] = [:]
    var startRecordOfResultsSet = 0
    let url = URL(string: Constants.kOrgUrl)


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
/*
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
*/
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            self.title = "Historic Places"
        }
        
        // Set parameter values for GET request to retrieve data
        parameters["limit"] = Constants.kMaxRecordsToReturn
        parameters["full"] = Constants.kRetrievedFullRecordDetails
        parameters["apikey"] = Constants.kApiKey
        parameters["offset"] = startRecordOfResultsSet

        // Use GET request to set place names for master view
        setPlaces()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        if isNetworkUp() {
            if isSignedIn() == false {
                // Popup icloud login screen
                let alert = getStandardAlert(title: Constants.kAccountLoginTitle, message: Constants.kAccountLoginMessage)
                alert.addAction(UIAlertAction(title:"Okay", style:.cancel, handler:nil));
                
                // Add popover to present
                let presenter = alert.popoverPresentationController
                presenter?.sourceView = self.view
                presenter?.sourceRect = self.view.bounds
                self.present(alert, animated: true, completion: nil)
            }
            else {
                // Get/create app username
                print("Signed in")
            }
        }
        else {
            let alert = getStandardAlert(title: Constants.kNetworkDownTitle, message: Constants.kNetworkDownMessage)
            
            // Add popover to present
            let presenter = alert.popoverPresentationController
            presenter?.sourceView = self.view
            presenter?.sourceRect = self.view.bounds
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
    @objc
    func insertNewObject(_ sender: Any) {
        places.insert(HistoricPlace(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    */

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let place = places[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.place = place
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath)

        let place = places[indexPath.row]
        place.placeUrl = ""
        cell.textLabel!.text = place.name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.lightGray
        } else {
            cell.backgroundColor = UIColor.gray
        }
    }

    // MARK: - Functions

    /**
     * Set the list of place names
     */
    func setPlaces() {
        // Retrieve places from web and add each instance to collection
        Alamofire.request(url!, parameters: parameters, encoding: URLEncoding.default, headers: httpHeaders).responseObject { (response: DataResponse<HistoricPlaces>) in
            switch response.result {
            case .success:
                // Successfully retrieved data, now marshall to a collection of objects
                if let value = response.result.value?.places {
                    // Marshalled, set historic places collection accordingly
                    if 0 != value.count {
                        // Results non-zero, add to array
                        for place in value {
                            // Create a historic place from JSON data
                            self.places.append(place)
                        }
                        // Increment offset accordingly and retrieve more results
                        self.startRecordOfResultsSet = self.places.count
                        self.parameters["offset"] = self.startRecordOfResultsSet
                        self.setPlaces()
                    } else {
                        // Results retrieved zero, now reload table view
                        self.tableView.reloadData()
                    }
                }
                
            // Reload table view to display data in cells
            case .failure (let error):
                // Failure retrieving JSON data, inform user
                print("Failure with response: \(error)")
                let dataAlert = UIAlertController(title: Constants.kErrorRetrievingDataTitle, message: error.localizedDescription, preferredStyle: .actionSheet)
                dataAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                // Add popover to present
                let presenter = dataAlert.popoverPresentationController
                presenter?.sourceView = self.view
                presenter?.sourceRect = self.view.bounds
                self.present(dataAlert, animated: true, completion: nil)
            }
        }
    }
 }

