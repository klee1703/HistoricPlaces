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
        
        // Increase font size for textfields
        addressField.font =  UIFont(name: (addressField.font?.fontName)!, size: (addressField.font?.pointSize)!+1)!
        cityField.font =  UIFont(name: (cityField.font?.fontName)!, size: (cityField.font?.pointSize)!+1)!
        stateField.font =  UIFont(name: (stateField.font?.fontName)!, size: (stateField.font?.pointSize)!+1)!
        countryField.font =  UIFont(name: (countryField.font?.fontName)!, size: (countryField.font?.pointSize)!+1)!
        postalCodeField.font =  UIFont(name: (postalCodeField.font?.fontName)!, size: (postalCodeField.font?.pointSize)!+1)!

        // Configure view
        configureView()
    }
    
    func configureView() {
        if let placeDetail = place {
            if let addressDetail = placeDetail.address {
                if addressDetail.count > 0 {
                    addressField.text = addressDetail[0].streetAddress1
                    cityField.text = addressDetail[0].city
                    stateField.text = addressDetail[0].stateCode
                    countryField.text = addressDetail[0].countryCode
                    let postalCode = addressDetail[0].postalCode
                    postalCodeField.text = String(postalCode)
                }
                if let directions = placeDetail.directions{
                    // Load directions web content, styling as specified
                    directionsWebView.loadHTMLString("<body style=\"background-color: lightgray; color: gray;\"><h1>" + directions + "</h1></body>", baseURL: nil)
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
