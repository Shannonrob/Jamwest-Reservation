//
//  Alert.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    private static func showActionSheetAlert(on vc: UIViewController, with title: String, message: String) {
        
    }
    
    static func showOverLimitComboDealTourSelections(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Exceeded Package Limit", message: "This package limits a maximum of 2 tours.")
   }
    
    static func showOverLimitSuperDealTourSelections(on vc: UIViewController) {
         showBasicAlert(on: vc, with: "Exceeded Package Limit", message: "This package limits a maximum of 3 tours.")
    }
    
    static func showOverLimitDeluxePackageTourSelections(on vc: UIViewController) {
         showBasicAlert(on: vc, with: "Exceeded Package Limit", message: "This package limits a maximum of 4 tours.")
    }
    
    static func showSuccessfullyCreatedReservation(on vc: UIViewController) {
         showBasicAlert(on: vc, with: "Success", message: "Your reservation was created.")
    }
    
    static func beforeSubmittingReservation(on vc: UIViewController) {
         showBasicAlert(on: vc, with: "Before submission", message: "Please verify reservation information is accurate.")
    }
    
    static func dayChangedDetected(on vc: UIViewController) {
         showBasicAlert(on: vc, with: "Day Changed", message: "Detected new date.")
    }
    
    static func showErrorMessage(on vc: UIViewController, with message: String) {
        showBasicAlert(on: vc, with: "", message: message)
    }
    
    static func signatureRequiredMessage(on vc: UIViewController, with message: String) {
        showBasicAlert(on: vc, with: "", message: message)
    }
    
    static func answersRequiredMessage(on vc: UIViewController, with message: String) {
        showBasicAlert(on: vc, with: "", message: message)
    }

}



