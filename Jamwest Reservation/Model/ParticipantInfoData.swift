//
//  ParticipantInfoData.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/20/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

class WaiverVerificationData {
    
    var reservationID: String
    var firstName: String
    var lastName: String
    var pregnantAnswer: String
    var ageAnswer: String
    var underInfluenceAnswer: String
    var backProblemAnswer: String
    var heartProblemAnswer: String
    
    init(reservationID: String, firstName: String, lastName: String, pregnantAnswer: String, ageAnswer: String, underInfluenceAnswer: String, backProblemAnswer: String, heartProblemAnswer: String) {
        
        self.reservationID = reservationID
        self.firstName = firstName
        self.lastName = lastName
        self.pregnantAnswer = pregnantAnswer
        self.ageAnswer = ageAnswer
        self.underInfluenceAnswer = underInfluenceAnswer
        self.backProblemAnswer = backProblemAnswer
        self.heartProblemAnswer = heartProblemAnswer
    }
}
