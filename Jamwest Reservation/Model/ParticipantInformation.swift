//
//  ParticipantInformation.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/19/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

class ParticipantInformation {
    
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var emailAddress: String
    var currentDate: String
    var country: String
    var guardianName: String
    
    var pregnantAnswer: Bool
    var ageAnswer: Bool
    var underInfluenceAnswer: Bool
    var backProblemAnswer: Bool
    var heartProblemAnswer: Bool
    
    init(firstName: String, lastName: String, phoneNumber: String, emailAddress: String, currentDate: String, country: String, guardianName: String, pregnantAnswer: Bool, ageAnswer: Bool, underInfluenceAnswer: Bool, backProblemAnswer: Bool, heartProblemAnswer: Bool) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.currentDate = currentDate
        self.country = country
        self.guardianName = guardianName
        self.pregnantAnswer = pregnantAnswer
        self.ageAnswer = ageAnswer
        self.underInfluenceAnswer = underInfluenceAnswer
        self.backProblemAnswer = backProblemAnswer
        self.heartProblemAnswer = heartProblemAnswer
    }
}
