//
//  DetailViewController.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/7/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    let hotelAbsolutePathPrefix = "http://www.historichotels.org/hotels-resorts/".lowercased()
    var hotelUrl: String?

    func configureView() {
        // Update the user interface for the detail item.
        if let placeDetail = place {
            // Set title for page
            self.title = placeDetail.name

            if let label = detailDescriptionLabel {
                label.text = self.hotelUrl
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hotelUrl = getHotelUrl(place: place!)
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var place: HistoricPlace? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func getHotelUrl(place: HistoricPlace) -> String {
        // Parse description to retrieve url

        // Check to confirm the JSON object contains a description string, if not return ""
        guard place.description != nil else {
            return ""
        }
        
        // Convert to all lower case
        let placeDescription = place.description!.lowercased()
        
        // Verify description contains path prefix
        if (placeDescription.contains(hotelAbsolutePathPrefix)) {
            // Find range for absolute path prefix
            let hotelsResortRange = placeDescription.range(of: hotelAbsolutePathPrefix)
            
            // Find index for position up to the path prefix
            let hotelPathUrlStartIndex = placeDescription.distance(from: (placeDescription.startIndex), to: (hotelsResortRange?.lowerBound)!)
            
            // Find first part of URL from hotel description
            // First find beginning of URL part
            let hotelPathStartUrl = placeDescription.dropFirst(Int(UInt((hotelPathUrlStartIndex.magnitude))))
            let hotelPathStartString = String(describing: hotelPathStartUrl) as String
            
            // Find range for hotel-resorts segment
            if let hotelResortsRange = hotelPathStartString.range(of: "hotels-resorts/") {
                
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
        
        // Conditions not satisfied, just return empty string
        return ""
    }
}

