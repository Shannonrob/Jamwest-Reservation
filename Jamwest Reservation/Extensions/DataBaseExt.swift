//
//  DataBaseExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/30/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Firebase

extension Database {
    
    static func fetchReservation(for currentDate: String, completion: @escaping(Reservation) -> ()) {
        
        // fetch reservation using current date
        RESERVATION_DATE_REF.child(currentDate).observe(.childAdded) { (snapshot) in
            
            let id = snapshot.key
            
            RESERVATION_REF.child(id).observe(.value) { (reservationSnapshot) in
                
                guard let dictionary = reservationSnapshot.value as? Dictionary<String, AnyObject> else { return }
                
                let reservation = Reservation(reservationId: id, dictionary: dictionary)
                
                completion(reservation)
            }
        }
    }
    
    static func fetchWaiver(from reference: DatabaseReference, completion: @escaping(ApprovedWaiver) -> ()) {
        
        reference.observe(.childAdded) { (snapshot) in
            
            // waiverID
            let waiverID = snapshot.key
            
            // snapshot value cast as dictionary
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            // construct waiver
            let waiver = ApprovedWaiver(waiverID: waiverID, dictionary: dictionary)
            
            completion(waiver)
        }
    }
}


