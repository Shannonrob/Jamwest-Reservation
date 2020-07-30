//
//  JWDatePicker.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 7/30/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JWDatePicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDatePicker() {
        
        var calendar: Calendar = Calendar.current
        let currentDate: Date = Date()
        var dateComponents: DateComponents = DateComponents()
        
        calendar.timeZone = TimeZone(identifier: "EST")!
        dateComponents.calendar = calendar
        dateComponents.year = +1
        
        let maxDate: Date = calendar.date(byAdding: dateComponents, to: currentDate)!
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = .some(currentDate as Date)
        datePicker.maximumDate = maxDate
        
        datePicker.backgroundColor = .white
        datePicker.setValue(UIColor.black, forKey: "textColor")
    }
}
