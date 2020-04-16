//
//  JamwestWaiverLabelClass.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/23/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JamwestWaiverLabelClass: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configuration()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // initialize constraints/views here
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuration() {
        
//        textColor = .darkText
//        textColor = Constants.Design.Color.Primary.HeavyGreen
        textColor = .darkGray
        textAlignment = .center
        font = UIFont.init(name: Font.helveticaNeueBold, size: 20)
    }
}


class RequiredLabelClass: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configuration()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // initialize constraints/views here
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuration() {
        
        text = "*Required"
        textColor = .systemRed
        isHidden = true
    }
}
