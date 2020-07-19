//
//  EmailListCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/22/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class EmailListCell: JamwestCell {
    
    var emailList : EmailList? {
        
        didSet {
            
            guard let firstName = emailList?.firstName,
                let lastName = emailList?.lastName,
                let email = emailList?.emailAddress else { return }
            
            firstNameLabel.text = firstName
            lastNameLabel.text = lastName
            detailLabel.text = email
        }
    }
}
