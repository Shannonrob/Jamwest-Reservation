//
//  WaiverVerification.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation


class WaiverVerification {
    
    var name: String!
    var firstTour: String!
    var secondTour: String!
    var thirdTour: String!
    var fourthTour: String!
    var pregnantAnswer: String!
    var minorAnswer: String!
    var underInfluenceAnswer: String!
    var heartAnswer: String!
    var backAnswer: String!
    var creationDate: Date!
    var waiverID: String!
    
    init(waiverID: String!, dictionary: Dictionary<String, AnyObject>) {
        
        self.waiverID = waiverID
        
        if let name = dictionary[Constant.name] as? String {
            self.name = name
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
        
        if let pregnantAnswer = dictionary[Constant.pregnantAnswer] as? String {
            self.pregnantAnswer = pregnantAnswer
        }
        
        if let minorAnswer = dictionary[Constant.minorAnswer] as? String {
            self.minorAnswer = minorAnswer
        }
        
        if let underInfluenceAnswer = dictionary[Constant.underInfluenceAnswer] as? String {
            self.underInfluenceAnswer = underInfluenceAnswer
        }
        
        if let heartAnswer = dictionary[Constant.heartAnswer] as? String {
            self.heartAnswer = heartAnswer
        }
        
        if let backAnswer = dictionary[Constant.backAnswer] as? String {
            self.backAnswer = backAnswer
        }
        
        if let creationDate = dictionary[Constant.creationDate] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
    }
}
