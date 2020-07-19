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
            
            guard let firstName = reservation?.firstName,
                let lastName = reservation?.lastName,
                let hotel = reservation?.hotel,
                let date = reservation?.date,
                let time = reservation?.time else { return }
            
            firstNameLabel.text = firstName
            lastNameLabel.text = lastName
            detailLabel.text = hotel
            dateLabel.text = "\(date) @ \(time)"
            
            selectionStyle = .none
        }
    }
}
