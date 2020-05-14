//
//  ApprovedWaiver.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/14/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

class ApprovedWaiver {
    
    var name: String!
    var date: String!
    var imageURL: String!
    var waiverID: String!
    
    init(waiverID: String!, dictionary: Dictionary<String, AnyObject>) {
        
        self.waiverID = waiverID
        
        if let name = dictionary[Constant.name] as? String {
            self.name = name
        }
        
        if let date = dictionary[Constant.creationDate] as? String {
            self.date = date
        }
        
        if let imageURL = dictionary[Constant.imageURL] as? String {
            self.imageURL = imageURL
        }
    }
}
