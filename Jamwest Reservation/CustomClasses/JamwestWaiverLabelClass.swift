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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuration() {
        
        text = "*Required"
        textColor = .systemRed
        isHidden = true
    }
}

// labels for textField header in AddReservationVC
class TextfieldHeaderLabel: UILabel {
    
    convenience init(text: String){
        self.init(frame: .zero)
        self.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        textColor = .darkGray
        font = UIFont(name: Font.avenirNextDemibold, size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// labels for textField header in AddReservationVC
class AddReservationLabel: UILabel {
    
    convenience init(text: String, textColor: UIColor, font: String, fontSize: CGFloat ){
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont(name: font, size: fontSize)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        textColor = .darkGray
        font = UIFont(name: Font.avenirNextDemibold, size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


