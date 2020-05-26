//
//  EditReservationCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/19/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class EditReservationCell: JamwestCell {
    
    var reservation : EditReservation? {
        
        didSet {
            
            guard let name = reservation?.group,
                let hotel = reservation?.hotel,
                let date = reservation?.date else { return }
            
            headerLabel.text = name
            detailLabel.text = hotel
            dateLabel.text = date
            
            selectionStyle = .none
        }
    }
}
