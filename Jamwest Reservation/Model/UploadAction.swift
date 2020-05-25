//
//  UploadAction.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/25/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

enum UploadAction: Int {
    
    case UploadReservation
    case SaveChanges
    
    init(index: Int) {
        
        switch index {
        case 0: self = .UploadReservation
        case 1: self = .SaveChanges
        default: self = .UploadReservation
        }
    }
}
