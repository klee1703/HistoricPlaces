//
//  AddressViewController.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/22/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit
import WebKit

class AddressViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var postalCodeField: UITextField!
    @IBOutlet weak var directionsWebView: WKWebView!
    // place
    var place: HistoricPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        directionsWebView.uiDelegate = self
        directionsWebView.layer.borderColor = UIColor.black.cgColor
        directionsWebView.layer.borderWidth = 1.0;
        if let placeDetail = place {
            if let addressDetail = placeDetail.address {
                addressField.text = addressDetail[0].streetAddress1
                cityField.text = addressDetail[0].city
                stateField.text = addressDetail[0].stateCode
                countryField.text = addressDetail[0].countryCode
                if let postalCode = addressDetail[0].postalCode {
                    postalCodeField.text = String(postalCode)
                }
                if let directions = placeDetail.directions{
                    directionsWebView.loadHTMLString("<body style=\"background-color: lightgray\"><h1>" + directions + "</h1></body>", baseURL: nil)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
