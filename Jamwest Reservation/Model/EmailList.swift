//
//  EmailList.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/22/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

class EmailList: Reservation {
    
    override init(reservationId: String!, dictionary: Dictionary<String, AnyObject>) {
        super.init(reservationId: reservationId, dictionary: dictionary)
    }
}
