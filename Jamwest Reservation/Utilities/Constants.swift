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


// Database parameters
let hotel_Name = "hotel"
let group_Name = "groupName"
let voucher_Number = "voucherNum"
let tour_Rep = "tourRep"
let tour_Company = "tourComp"
let pax_Count = "pax"
let tour_Package = "tourPackage"
let reservation_Time = "time"
let reservation_Date = "date"
let reservation_Id = "reservationId"
let first_Tour = "firstTour"
let second_Tour = "secondTour"
let third_Tour = "thirdTour"
let forth_Tour = "fourthTour"


// Fonts
let avenirNext_Demibold = "AvenirNext-DemiBold"
let avenirNext_Heavy = "AvenirNext-Heavy"
let helveticaNeue = "HelveticaNeue"
let helveticaNeue_Medium = "HelveticaNeue-Medium"
let helveticaNeue_Bold = "HelveticaNeue-Bold"
let avenirNext_Medium = "AvenirNext-Medium"
let avenirNext_Regular = "AvenirNext-Regular"

// Button title
let single_Tour = "Single Tour"
let combo_Deal = "Combo Deal"
let super_Deal = "Super Deal"
let deluxe_Package = "Deluxe Pkg"

// Image name
let white_CheckMark = "whiteCheckMark"
let clear_CheckMark = "hiddenCheckMark"
let orange_Race_Flag_Icon = "orangeRaceFlagIcon"

// Notification Keys
let date_Changed_key = "NSCalendarDayChangedNotification"

// Notifying ToursSelectionVC which package was selected in AddReservationVC
//var tour_Package_Selected = String()

// Catch the reservationId for each reservation and pass it to ToursSelectionVC
//var reservation_ID = String()

struct Constants {
    
    struct Design {
        
        struct Color {
            
            struct Primary {
                static let Orange = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
                static let Purple = UIColor(displayP3Red: 17/255, green: 16/255, blue: 38/255, alpha: 95)
                static let Green = UIColor(displayP3Red: 0/255, green: 162/255, blue: 138/255, alpha: 1)
                static let HeavyGreen = UIColor(displayP3Red: 0/255, green: 81/255, blue: 82/255, alpha: 1)
                static let LightPurple = UIColor(displayP3Red: 17/255, green: 16/255, blue: 95/255, alpha: 100)
                static let MenuBlue = UIColor(displayP3Red: 17/255, green: 16/255, blue: 160/255, alpha: 100)
                static let MarkerColor = UIColor(red: 0/255, green: 133/255, blue: 81/255, alpha: 1)
                
            }
            
            struct Border {
                static let Orange = CGColor.init(srgbRed: 242/255, green: 125/255, blue: 15/255, alpha: 1)
                static let Purple = CGColor.init(srgbRed: 17/255, green: 16/255, blue: 38/255, alpha: 95)
                static let Blue = CGColor.init(srgbRed: 0.50, green: 0.66, blue: 0.66, alpha: 1)
            }
            
            struct Background {
                static let FadeGray = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
            }
            
            struct Hue {
                static let Green = UIColor(hue: 0.50, saturation: 0.66, brightness: 0.66, alpha: 1)
            }
            
            struct FadedHue {
                static let Green = UIColor(hue: 0.50, saturation: 0.20, brightness: 0.66, alpha: 1)
            }
        }
    }
}
