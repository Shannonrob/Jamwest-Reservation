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
        
        textColor = .darkText
        numberOfLines = 2
        textAlignment = .center
        font = UIFont.init(name: helveticaNeue_Bold, size: 22)
    }
}
