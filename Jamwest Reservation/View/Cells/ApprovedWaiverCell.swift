//
//  ApprovedWaiverCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/14/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ApprovedWaiverCell: JamwestCell {
    
    var approvedWaiver: ApprovedWaiver? {
        
        didSet {
            
            guard let name = approvedWaiver?.name else { return }
//            guard let imageURL = approvedWaiver?.imageURL else { return }
            guard let date = approvedWaiver?.creationDate else { return}
            
            headerLabel.text = name
            detailLabel.text = date
        }
    }
}
