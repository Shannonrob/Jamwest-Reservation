//
//  MenuOption.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {

    case Submit
    case Waivers
    case Reservations
    case LogOut
    
    var description: String{
        switch self {
        case .Submit: return "SUBMIT EMAILS"
        case.Waivers: return "WAIVERS"
        case.Reservations: return "ADD RESERVATIONS"
        case.LogOut: return "SIGN OUT"
            
        }
    }
    
    var iconImage: UIImage{
          switch self {
          case .Submit: return UIImage(named: "Email") ?? UIImage()
          case.Waivers: return UIImage(named: "Waivers") ?? UIImage()
          case.Reservations: return UIImage(named: "Calender") ?? UIImage()
          case.LogOut: return UIImage(named: "Settings") ?? UIImage()
              
          }
      }
}
