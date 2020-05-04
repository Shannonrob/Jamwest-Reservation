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
    case Modification
    case Submit
    case Verification
    case LogOut
    
    var description: String{
        
        switch self {
        case.Reservations: return "ADD RESERVATIONS"
        case.Modification: return "MODIFY RESERVATION"
        case.Submit: return "SUBMIT EMAILS"
        case.Verification: return "WAIVERS VERIFICATION"
        case.LogOut: return "SIGN OUT"
        }
    }
    
    var iconImage: UIImage{
        
        switch self {
        case.Reservations: return UIImage(named: "Calender") ?? UIImage()
        case.Modification: return UIImage(named: "Waivers" ) ?? UIImage()
        case.Submit: return UIImage(named: "Email") ?? UIImage()
        case.Verification: return UIImage(named: "verification_Icon") ?? UIImage()
        case.LogOut: return UIImage(named: "Settings") ?? UIImage()
        }
    }
}
