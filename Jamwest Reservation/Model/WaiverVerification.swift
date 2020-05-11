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
    var imageURL: String!
    var firstTour: String!
    var secondTour: String!
    var thirdTour: String!
    var fourthTour: String!
    var pregnantAnswer: Bool!
    var minorAnswer: Bool!
    var underInfluenceAnswer: Bool!
    var heartAnswer: Bool!
    var backAnswer: Bool!
    var creationDate: Date!
    var waiverID: String!
    
    init(waiverID: String!, dictionary: Dictionary<String, AnyObject>) {
        
        self.waiverID = waiverID
        
        if let imageURL = dictionary[Constant.imageURL] as? String {
            self.imageURL = imageURL
        }
        
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
        
        if let pregnantAnswer = dictionary[Constant.pregnantAnswer] as? Bool {
            self.pregnantAnswer = pregnantAnswer
        }
        
        if let minorAnswer = dictionary[Constant.minorAnswer] as? Bool {
            self.minorAnswer = minorAnswer
        }
        
        if let underInfluenceAnswer = dictionary[Constant.underInfluenceAnswer] as? Bool {
            self.underInfluenceAnswer = underInfluenceAnswer
        }
        
        if let heartAnswer = dictionary[Constant.heartAnswer] as? Bool {
            self.heartAnswer = heartAnswer
        }
        
        if let backAnswer = dictionary[Constant.backAnswer] as? Bool {
            self.backAnswer = backAnswer
        }
        
        if let creationDate = dictionary[Constant.creationDate] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
    }
    
    func rejectWaiver(id waiverID: String) {
        
        PARTICIPANT_WAIVER_REF.child(waiverID).removeValue { (error, ref) in
            WAIVER_IMAGE_REF.child(waiverID).delete(completion: nil)
        }
    }
}
