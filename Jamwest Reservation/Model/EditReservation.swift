//
//  EditReservation.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/19/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

class EditReservation: Reservation {
    
    override init(reservationId: String!, dictionary: Dictionary<String, AnyObject>) {
        super.init(reservationId: reservationId, dictionary: dictionary)
    }
}
