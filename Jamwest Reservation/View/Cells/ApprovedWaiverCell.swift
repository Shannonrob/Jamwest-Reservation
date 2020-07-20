//
//  ApprovedWaiverCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/14/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ApprovedWaiverCell: JWTableViewCell {
    
    var approvedWaiver: ApprovedWaiver? {
        
        didSet {
            
            guard let firstName = approvedWaiver?.firstName,
                let lastName = approvedWaiver?.lastName,
             let date = approvedWaiver?.creationDate else { return}
            
            #warning("check back with this for the image")
//            guard let imageURL = approvedWaiver?.imageURL else { return }
            
            
            firstNameLabel.text = firstName
            lastNameLabel.text = lastName
            detailLabel.text = date
        }
    }
}
