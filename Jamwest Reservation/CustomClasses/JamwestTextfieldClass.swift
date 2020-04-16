//
//  JamwestTextfieldClass.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JamwestTextfieldClass: UITextField {

     convenience init() {
           self.init(frame: .zero)
           
           backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           font?.withSize(18)
           layer.borderWidth = 0.85
           layer.cornerRadius = 4
           layer.masksToBounds = true
           borderStyle = .roundedRect
           layer.borderColor = Color.Border.blue
           widthAnchor.constraint(equalToConstant: 400).isActive = true
           heightAnchor.constraint(equalToConstant: 51).isActive = true
       }
}
