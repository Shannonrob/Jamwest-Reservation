//
//  JamwestCustomRoundedButton.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JamwestCustomRoundedButton: UIButton {
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // initialize constraints/views here
        configuration()
    }
    
    func configuration() {
        
//        titleLabel?.font = .systemFont(ofSize: 20)
        titleLabel?.font = UIFont(name: avenirNext_Demibold, size: 20)
        titleLabel?.textColor = .white
        backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.20)
        layer.cornerRadius = 20
        layer.borderWidth = 1.5
        layer.borderColor = Constants.Design.Color.Background.FadeGray.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2.75
        layer.shadowOpacity = 1.0
    }
}

