//
//  MenuOption.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Reservations
    case Edit
    case Submit
    case Verification
    case LogOut
    
    var description: String{
        
        switch self {
        case.Reservations: return "ADD RESERVATION"
        case.Edit: return "EDIT RESERVATION"
        case.Submit: return "SUBMIT EMAILS"
        case.Verification: return "WAIVER VERIFICATION"
        case.LogOut: return "SIGN OUT"
        }
    }
    
    var iconImage: UIImage{
        
        switch self {
        case.Reservations: return UIImage(named: "Calender") ?? UIImage()
        case.Edit: return UIImage(named: "Waivers" ) ?? UIImage()
        case.Submit: return UIImage(named: "Email") ?? UIImage()
        case.Verification: return UIImage(named: "verification_Icon") ?? UIImage()
        case.LogOut: return UIImage(named: "Settings") ?? UIImage()
        }
    }
}
