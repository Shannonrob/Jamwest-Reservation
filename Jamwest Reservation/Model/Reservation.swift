//
//  Reservation.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

class Reservation {
    
    var time: String!
    var firstName: String!
    var lastName: String!
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
    var date: String!
    
    init(reservationId: String!, dictionary: Dictionary<String, AnyObject>) {
        
        self.reservationId = reservationId
        
        if let time = dictionary[Constant.reservationTime] as? String {
            self.time = time
        }
        
        if let firstName = dictionary[Constant.firstName] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictionary[Constant.lastName] as? String {
            self.lastName = lastName
        }
        
        if let hotel = dictionary[Constant.hotelName] as? String {
            self.hotel = hotel
        }
        
        if let firstTour = dictionary[Constant.firstTour] as? String {
            self.firstTour = firstTour
        }
        
        if let secondTour = dictionary[Constant.secondTour] as? String {
            self.secondTour = secondTour
        }
        
        if let thirdTour = dictionary[Constant.thirdTour] as? String {
            self.thirdTour = thirdTour
        }
        
        if let fourthTour = dictionary[Constant.fourthTour] as? String {
            self.fourthTour = fourthTour
        }
        
        if let package = dictionary[Constant.tourPackage] as? String {
            self.package = package
        }
        
        if let pax = dictionary[Constant.paxCount] as? Int {
            self.pax = pax
        }
        
        if let tourCompany = dictionary[Constant.tourCompany] as? String {
            self.tourCompany = tourCompany
        }
        
        if let tourRep = dictionary[Constant.tourRep] as? String {
            self.tourRep = tourRep
        }
        
        if let voucherNumber = dictionary[Constant.voucherNumber] as? String {
            self.voucherNumber = voucherNumber
        }
        
        if let date = dictionary[Constant.reservationDate ] as? String {
            self.date = date
        }
    }
    
    // update pax value or delete reservation after each waiver is signed
    func updateWaiverBalance(for currentDate: String) {
        
        // decrease reservation quantity or remove reservation
        if pax == 1 {
            
            RESERVATION_REF.child(reservationId).removeValue()
            
        } else if pax > 1 {
            
            pax = pax - 1
            RESERVATION_REF.child(reservationId).child(Constant.paxCount).setValue(pax)
        }
    }
}
