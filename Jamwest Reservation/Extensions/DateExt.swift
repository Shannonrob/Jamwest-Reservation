//
//  DateExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/15/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension Date {
    
    static func CurrentDate() -> String {
        
        var calendar: Calendar = Calendar.current
        let currentDate: Date = Date()
        var dateComponents: DateComponents = DateComponents()
        
        calendar.timeZone = TimeZone(identifier: "EST")!
        dateComponents.calendar = calendar
        
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateStyle = .medium
        
        let date = currentDateFormatter.string(from: currentDate)
        return date
    }
}


