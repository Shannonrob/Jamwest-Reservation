//
//  Reservation.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

class Reservation {
    
//    var date: String!
    var time: String!
    var group: String!
    var hotel: String!
    var firstTour: String!
    var secondTour: String!
    var thirdTour: String!
    var fourthTour: String!
    var package: String!
    var pax: Int!
    var tourCompany: String!
    var tourRep: String!
    var voucherNumber: String!
    var reservationId: String!
    
    init(reservationId: String!, dictionary: Dictionary<String, AnyObject>) {
        
        self.reservationId = reservationId
        
//        if let date = dictionary[reservation_Date] as? String {
//            self.date = date
//        }
        
        if let time = dictionary[Constant.reservation_Time] as? String {
            self.time = time
        }
        
        if let group = dictionary[Constant.group_Name] as? String {
            self.group = group
        }
        
        if let hotel = dictionary[Constant.hotel_Name] as? String {
            self.hotel = hotel
       }
        
        if let firstTour = dictionary[Constant.first_Tour] as? String {
            self.firstTour = firstTour
        }
        
        if let secondTour = dictionary[Constant.second_Tour] as? String {
            self.secondTour = secondTour
        }
        
        if let thirdTour = dictionary[Constant.third_Tour] as? String {
            self.thirdTour = thirdTour
        }
        
        if let forthTour = dictionary[Constant.forth_Tour] as? String {
            self.fourthTour = forthTour
        }
        
        if let package = dictionary[Constant.tour_Package] as? String {
            self.package = package
        }
        
        if let pax = dictionary[Constant.pax_Count] as? Int {
            self.pax = pax
        }
        
        if let tourCompany = dictionary[Constant.tour_Company] as? String {
            self.tourCompany = tourCompany
        }
        
        if let tourRep = dictionary[Constant.tour_Rep] as? String {
            self.tourRep = tourRep
        }
        
        if let voucherNumber = dictionary[Constant.voucher_Number] as? String {
            self.voucherNumber = voucherNumber
        }
    }
}
