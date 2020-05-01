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
}


