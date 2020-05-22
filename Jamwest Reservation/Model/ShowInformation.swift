//
//  ShowInformation.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/22/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

enum ShowInformation: Int {
    
    case EditReservation
    case EmailList
    
    init(index: Int) {
        
        switch index {
        case 0: self = .EditReservation
        case 1: self = .EmailList
        default: self = .EditReservation
            
        }
    }
}
