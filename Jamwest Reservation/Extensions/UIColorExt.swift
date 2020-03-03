//
//  UIColorExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension UIColor {
    
   func configureColor (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
       return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
