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
    case Modify
    case Submit
    case Waivers
    case LogOut
    
    var description: String{
        
        switch self {
        case.Reservations: return "ADD RESERVATIONS"
        case.Modify: return "MODIFY RESERVATION"
        case.Submit: return "SUBMIT EMAILS"
        case.Waivers: return "WAIVERS VERIFICATION"
        case.LogOut: return "SIGN OUT"
        }
    }
    
    var iconImage: UIImage{
        
        switch self {
        case.Reservations: return UIImage(named: "Calender") ?? UIImage()
        case.Modify: return UIImage(named: "Waivers" ) ?? UIImage()
        case.Submit: return UIImage(named: "Email") ?? UIImage()
        case.Waivers: return UIImage(named: "verification_Icon") ?? UIImage()
        case.LogOut: return UIImage(named: "Settings") ?? UIImage()
        }
    }
}
