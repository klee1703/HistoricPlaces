//
//  Utilities.swift
//  HistoricPlaces
//
//  Created by Keith Lee on 12/7/17.
//  Copyright © 2017 Keith Lee. All rights reserved.
//

//
//  Utilities.swift
//  Cryptext
//
//  Created by Keith Lee on 1/6/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

func setUserID(_ userID: CKRecordID) {
    CKContainer.default().fetchUserRecordID(){ recordID, error in
        if error != nil {
            print("Error retrieving iCloud user ID")
        }
    }
}

// Return current user icloud account status
func isSignedIn() -> Bool {
    return FileManager.default.ubiquityIdentityToken != nil ? true : false
}


func getSharedSecret(_ to: String, from: String, date: Date) -> String {
    return "\(to).\(from).\(date.description)"
}


func getStandardAlert(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    return alert
}

extension URLSession {
    func sendSynchronousRequest(_ request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, NSError?) -> Void) {
        let semaphore = DispatchSemaphore(value: 0)
        let task = self.dataTask(with: request, completionHandler: { data, response, error in
            completionHandler(data, response, error as NSError?)
            semaphore.signal()
        })
        
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    }
}


func isNetworkUp() -> Bool {
    let request = URLRequest(url: URL(string: "http://www.apple.com")!)
    var status = false
    URLSession.shared.sendSynchronousRequest(request) { data, response, error in
        if let response = response {
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                status = true
            }
        }
    }    
    return status
}

