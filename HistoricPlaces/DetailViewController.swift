//
//  DetailViewController.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/7/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var url: UITextField!
    
    // place
    var place: HistoricPlace?
    
    // First part of hotel URL
    let hotelUrlPrefix = Constants.kDefaultHotelUrl + Constants.kHotelResortsUrlSegment

    func configureView() {
        // Update the user interface for the detail item.
        if let placeDetail = place {
            placeDetail.placeUrl = getHotelUrl(place: placeDetail)
            // Set title for page
            self.title = placeDetail.name
            descriptionView.text = placeDetail.description
            emailAddress.text = placeDetail.email
            phoneNumber.text = placeDetail.phone
            url.text = placeDetail.placeUrl
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     * Parse description to retrieve hotel URL
     */
    func getHotelUrl(place: HistoricPlace) -> String {
        let url = Constants.kDefaultHotelUrl
        if let links = place.links {
            for link in links {
                switch link.linkType! {
                case LinkType.WebSite.rawValue:
                    return link.url!
                default:
                    continue
                }
            }
        }
        return url
    }

    func getDescription(place: HistoricPlace) -> String {
        /*
         // Check to confirm the JSON object contains a description string, if not return default URL
         guard place.description != nil else {
         return Constants.kDefaultHotelUrl
         }
         
         // Convert to all lower case
         let placeDescription = place.description!.lowercased()
         
         // Verify description contains path prefix
         if (placeDescription.contains(hotelUrlPrefix)) {
         // Find range for absolute path prefix
         let hotelsResortRange = placeDescription.range(of: hotelUrlPrefix)
         
         // Find index for position up to the path prefix
         let hotelPathUrlStartIndex = placeDescription.distance(from: (placeDescription.startIndex), to: (hotelsResortRange?.lowerBound)!)
         
         // Find first part of URL from hotel description
         // First find beginning of URL part
         let hotelPathStartUrl = placeDescription.dropFirst(Int(UInt((hotelPathUrlStartIndex.magnitude))))
         let hotelPathStartString = String(describing: hotelPathStartUrl) as String
         
         // Find range for hotel-resorts segment
         if let hotelResortsRange = hotelPathStartString.range(of: Constants.kHotelResortsUrlSegment) {
         
         // Find url string up to end of hotel-resorts segment
         let urlToHotelResortsSegment = hotelPathStartString[..<hotelResortsRange.upperBound]
         
         // Find string from start of URL to end
         let urlHotelResortsToEnd = hotelPathStartString[hotelResortsRange.upperBound...]
         
         // Extract hotel-resorts name
         var hotelName = ""
         for index in urlHotelResortsToEnd.indices {
         // Traverse segment until terminator ('/') reached, building the hotel name
         if String(urlHotelResortsToEnd[index]) != "/" {
         hotelName.append(urlHotelResortsToEnd[index])
         } else {
         // Done building name, break out of loop
         break
         }
         }
         // Set complete URL by appending hotel-resorts name
         let url = String(urlToHotelResortsSegment) + hotelName + "/"
         return url
         }
         }
         
         // Conditions not satisfied, just return default URL
         return Constants.kDefaultHotelUrl
         */
        return ""
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addressSegue" {
            let controller = (segue.destination as! UINavigationController).topViewController as! AddressViewController
            controller.place = place
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        } else if segue.identifier == "notesSegue" {
            let controller = (segue.destination as! UINavigationController).topViewController as! NotesViewController
            controller.place = place
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}

