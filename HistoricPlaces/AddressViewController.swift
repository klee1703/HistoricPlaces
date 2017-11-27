//
//  AddressViewController.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 11/22/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var postalCodeField: UITextField!
    @IBOutlet weak var directionsView: UITextView!

    // place
    var place: HistoricPlace?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let placeDetail = place {
            directionsView.text = placeDetail.directions
            if let addressDetail = placeDetail.address {
                addressField.text = addressDetail[0].streetAddress1
                cityField.text = addressDetail[0].city
                stateField.text = addressDetail[0].stateCode
                countryField.text = addressDetail[0].countryCode
                if let postalCode = addressDetail[0].postalCode {
                    postalCodeField.text = String(postalCode)
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
