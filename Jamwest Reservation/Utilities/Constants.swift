//
//  Constants.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Firebase
import UIKit

// Database Refences
let DB_REF = Database.database().reference()
let USER_REF = DB_REF.child("users")
let RESERVATION_REF = DB_REF.child("reservations")
let RESERVATION_DATE_REF = DB_REF.child("reservation-Date")
let PARTICIPANT_WAIVER_REF = DB_REF.child("participant-Waiver")

enum Constant {
    
    static let name = "name"
    static let hotelName = "hotel"
    static let groupName = "groupName"
    static let voucherNumber = "voucherNum"
    static let tourRep = "tourRep"
    static let tourCompany = "tourComp"
    static let paxCount = "pax"
    static let tourPackage = "tourPackage"
    static let reservationTime = "time"
    static let reservationDate = "date"
    static let reservationId = "reservationId"
    static let firstTour = "firstTour"
    static let secondTour = "secondTour"
    static let thirdTour = "thirdTour"
    static let fourthTour = "fourthTour"
    static let prenantAnswer = "pregnantAnswer"
    static let minorAnswer = "minorAnswer"
    static let underInfluenceAnswer = "influenceAnswer"
    static let heartAnswer = "heartAnswer"
    static let backAnswer = "backAnswer"
}

enum Font {
    
    static let avenirNextRegular = "AvenirNext-Regular"
    static let avenirNextMedium = "AvenirNext-Medium"
    static let avenirNextDemibold = "AvenirNext-DemiBold"
    static let avenirNextHeavy = "AvenirNext-Heavy"
    static let helveticaNeue = "HelveticaNeue"
    static let helveticaNeueMedium = "HelveticaNeue-Medium"
    static let helveticaNeueBold = "HelveticaNeue-Bold"
}

enum ButtonTitle {
    
    static let singleTour = "Single Tour"
    static let comboDeal = "Combo Deal"
    static let superDeal = "Super Deal"
    static let deluxePackage = "Deluxe Pkg"
}

enum ImageName {

    static let whiteCheckMark = "whiteCheckMark"
    static let clearCheckMark = "hiddenCheckMark"
}

enum Listener {
    
    // Notification Keys
   static let dateChangedKey = "NSCalendarDayChangedNotification"
}

enum Color {
    
    struct Primary {
        
        static let orange = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
        static let purple = UIColor(displayP3Red: 17/255, green: 16/255, blue: 38/255, alpha: 95)
        static let green = UIColor(displayP3Red: 0/255, green: 162/255, blue: 138/255, alpha: 1)
        static let heavyGreen = UIColor(displayP3Red: 0/255, green: 81/255, blue: 82/255, alpha: 1)
        static let lightPurple = UIColor(displayP3Red: 17/255, green: 16/255, blue: 95/255, alpha: 100)
        static let menuBlue = UIColor(displayP3Red: 17/255, green: 16/255, blue: 160/255, alpha: 100)
        static let markerColor = UIColor(red: 0/255, green: 133/255, blue: 81/255, alpha: 1)
    }
    
    struct Border {
        
        static let orange = CGColor.init(srgbRed: 242/255, green: 125/255, blue: 15/255, alpha: 1)
        static let purple = CGColor.init(srgbRed: 17/255, green: 16/255, blue: 38/255, alpha: 95)
        static let blue = CGColor.init(srgbRed: 0.50, green: 0.66, blue: 0.66, alpha: 1)
    }
    
    struct Background {
        
        static let fadeGray = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
    }
    
    struct Hue {
        
        static let green = UIColor(hue: 0.50, saturation: 0.66, brightness: 0.66, alpha: 1)
        static let fadedGreen = UIColor(hue: 0.50, saturation: 0.20, brightness: 0.66, alpha: 1)
    }
}


