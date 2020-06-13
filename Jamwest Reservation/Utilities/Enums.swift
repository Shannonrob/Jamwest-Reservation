//
//  UploadAction.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/25/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

enum CameraAction: Int{
    
    case CaptureProfileImage
    case UpdateProfileImage
    
    init(index: Int) {
        
        switch index {
        case 0: self = .CaptureProfileImage
        case 1: self = .UpdateProfileImage
        default: self = .CaptureProfileImage
        }
    }
}

enum ReservationPackage: Int, CustomStringConvertible {
    
    case SingleTour
    case ComboDeal
    case SuperDeal
    case DeluxePackage
    
    init(index: Int) {
        
        switch index {
        case 0: self = .SingleTour
        case 1: self = .ComboDeal
        case 2: self = .SuperDeal
        case 3: self = .DeluxePackage
        default: self = .SingleTour
        }
    }
    
    var description: String{
        
        switch self {
        case.SingleTour: return "Single Tour"
        case.ComboDeal: return "Combo Deal"
        case.SuperDeal: return "Super Deal"
        case.DeluxePackage: return "Deluxe Package"
        }
    }
}

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

enum Waivers {
    case PendingWaivers
    case ApprovedWaivers
}

