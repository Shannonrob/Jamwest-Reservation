//
//  NetworkManager.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 7/16/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    //    MARK: - EditReservationVC
    
    func checkDataBaseEmptyState(for reference: DatabaseReference,completed: @escaping (Result<DataSnapshot, JWError>) -> Void) {
        reference.observeSingleEvent(of: .value) { (snapShot, error) in
            
            if let _ = error {
                completed(.failure(.malfunction))
                return
            } else {
                completed(.success(snapShot))
            }
        }
    }
    
    
    func fetchEmailList(completed: @escaping (Result<EmailList, JWError>) -> Void) {
        PARTICIPANT_EMAIL_REF.observe(.value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach { (snapshot) in
                    
                    let emailID = snapshot.key
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    let email = EmailList(waiverID: emailID, dictionary: dictionary)
                    completed(.success(email))
                }
            }
        }
    }
    
    
    func fetchReservation(limit value: Int, startingPoint: String, completed: @escaping (Result<EditReservation, JWError>) -> Void) {
        RESERVATION_REF.queryOrdered(byChild: Constant.fullNameReversed).queryStarting(atValue: startingPoint).queryLimited(toFirst: UInt(value)).observe(.value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach { (snapshot) in
                    
                    let reservationID = snapshot.key
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    let reservation = EditReservation(reservationId: reservationID, dictionary: dictionary)
                    completed(.success(reservation))
                }
            }
        }
    }

        
    func deleteSubscriberEmail(for id: String) { PARTICIPANT_EMAIL_REF.child(id).removeValue() }
    
    
    func searchReservations(completed: @escaping(Result<EditReservation, JWError>) -> Void) {
        RESERVATION_REF.observeSingleEvent(of: .value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach { (snapshot) in
                    
                    let reservationID = snapshot.key
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    let reservation = EditReservation(reservationId: reservationID, dictionary: dictionary)
                    completed(.success(reservation))
                }
            }
        }
    }
    
    
    //    MARK: - HomeVC
    
    func checkReservationsEmptyState(for date: String, completed: @escaping (Result<DataSnapshot, JWError>) -> Void) {
        RESERVATION_DATE_REF.child(date).observeSingleEvent(of: .value) { (snapshot, error) in
            if let _ = error {
                completed(.failure(.malfunction))
                return
            } else {
                completed(.success(snapshot))
            }
        }
    }
    
        
    func fetchReservations(for date: String, fetch value: Int, starting startPoint: String, completed: @escaping (Result<Reservation, JWError>) -> Void) {
        
        RESERVATION_DATE_REF.child(date).queryOrdered(byChild: Constant.fullNameReversed).queryLimited(toFirst: UInt(value)).queryStarting(atValue: startPoint).observe( .value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else {
                    completed(.failure(.malfunction))
                    return
                }
                
                allObjects.forEach { (snapshot) in
                    
                    let reservationID = snapshot.key
                    
                    RESERVATION_REF.child(reservationID).observe(.value) { (snapshot, err) in
                        
                        if let _ = err {
                            completed(.failure(.unableToCompleteRequest))
                            return
                        }else {
                            
                            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else {
                                completed(.failure(.malfunction))
                                return
                            }
                            let reservation = Reservation(reservationId: reservationID, dictionary: dictionary)
                            completed(.success(reservation))
                        }
                    }
                }
            }
        }
    }
    
    
    func observeReservationDeleted(for date: String, completed: @escaping (Result<DataSnapshot, JWError>) -> Void) {
        RESERVATION_DATE_REF.child(date).observe(.childRemoved) { (snapshot) in
            completed(.success(snapshot))
        }
    }
    
    
    func searchCurrentReservations(forDate date: String, completed: @escaping(Result<Reservation, JWError>) -> Void) {
        RESERVATION_REF.queryOrdered(byChild: Constant.reservationDate).queryEqual(toValue: date).observeSingleEvent(of: .value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach { (snapshot) in
                    
                    let reservationID = snapshot.key
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    let reservation = Reservation(reservationId: reservationID, dictionary: dictionary)
                    completed(.success(reservation))
                }
            }
        }
    }
    
    
    //    MARK: - LogInVC
    
    func attempLogIn(withEmail email: String, password: String, completed: @escaping (Result<String?, JWError>) -> Void) {
        Auth.auth().signIn(withEmail: email , password: password) { (result, error) in
            
            if let error = error {
                
                switch error.localizedDescription {
                case JWError.noUser.rawValue :
                    completed(.failure(.invalidEmailMessage))
                    
                case JWError.invalidPassword.rawValue :
                    completed(.failure(.invalidPasswordMessage))
                    
                default:
                    completed(.failure(.unableToComplete))
                }
                return
            } else {
                completed(.success(.none))
            }
        }
    }
    
    
    //    MARK: - ReviewVC
    
    func updateWaiver(with image: UIImage, waiverID: String, completed: @escaping (Result <String?, JWError>) -> Void) {
        guard let uploadData = image.jpegData(compressionQuality: 0.75) else { return }
        
        WAIVER_IMAGE_REF.child(waiverID).putData(uploadData, metadata: nil) { [weak self] (metadata, error) in
            guard let _ = self else { return }
            
            if let _ = error { completed(.failure(.unableToCompleteRequest))
                return
            }
            
            // download image url
            WAIVER_IMAGE_REF.child(waiverID).downloadURL { (url, error) in
                
                if let _ = error { completed(.failure(.unableToCompleteRequest))
                    return
                } else {
                    
                    // save url as string
                    guard let imageUrl = url?.absoluteString else { return }
                    let dictionary = [Constant.imageURL : imageUrl]
                    PARTICIPANT_WAIVER_REF.child(waiverID).updateChildValues(dictionary)
                    completed(.success(dictionary[Constant.imageURL]))
                }
            }
        }
    }
    
    
    func approveWaiver(for waiverID: String, with values: Dictionary<String, Any>, completed: @escaping (Result<String ,JWError>) -> Void) {
        let approvedWaiverID = APPROVED_WAIVER_REF.child(waiverID)
        approvedWaiverID.updateChildValues(values) { [weak self] (error, ref) in
            guard let _ = self else { return }
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                completed(.success(waiverID))
            }
        }
    }
    
    
    //    MARK: - SignUp VC
    
    func createUser(withEmail email: String, username: String, password: String, completed: @escaping (Result<String?, JWError>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let _ = error {
                completed(.failure(.invalidEmailMessage))
                return
            } else {
                
                guard let uid = user?.user.uid else { return }
                let dictionaryValues = ["username": username]
                let values = [uid: dictionaryValues]
                
                USER_REF.updateChildValues(values) { (err, reference) in
                    
                    if let _ = err {
                        completed(.failure(.malfunction))
                        return
                    } else {
                        completed(.success(.none))
                    }
                }
            }
        }
    }
    
    
    //    MARK: - TourSelectionVC
    
    func createReservation(forDate date:String, name nameReversed: Dictionary<String, Any>, with values: Dictionary<String, Any>, completed: @escaping (Result<String? ,JWError>) -> Void) {
        let reservation = RESERVATION_REF.childByAutoId()
        reservation.updateChildValues(values) { (err, ref) in
            
            if let _ = err {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                guard let reservationId = ref.key else { return }
                
                RESERVATION_DATE_REF.child(date).child(reservationId).updateChildValues(nameReversed) { (error, ref) in
                    if let _ = error {
                        completed(.failure(.unableToCompleteRequest))
                        return
                    } else {
                        completed(.success(.none))
                    }
                }
            }
        }
    }
    
    
    func updateReservationDate(reservation reservationID: String, replace oldDate: String, with new_Date: String, fullNameReversed: Dictionary<String, Any>, reservationValues: Dictionary<String, Any>, completed: @escaping (Result<String? ,JWError>) -> Void) {
        
        RESERVATION_REF.child(reservationID).updateChildValues(reservationValues) { (error, ref) in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                RESERVATION_DATE_REF.child(oldDate).child(reservationID).removeValue { (err, ref) in
                    if let _ = error {
                        completed(.failure(.unableToCompleteRequest))
                        return
                    } else {
                        
                        RESERVATION_DATE_REF.child(new_Date).child(reservationID).updateChildValues(fullNameReversed)
                        completed(.success(.none))
                    }
                }
            }
        }
    }
    
    
    func updateReservationValues(reservation reservationID: String, reservationValues: Dictionary<String, Any>, completed: @escaping (Result<String? ,JWError>) -> Void) {
        
        RESERVATION_REF.child(reservationID).updateChildValues(reservationValues) { (error, ref) in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                completed(.success(.none))
            }
        }
    }
    
    
    #warning("handle at a later time can be used for editReservationVC deletion of reservation")
//    func removeDateRef(previousDate date: String, reservationId ID: String, with name: Dictionary<String, Any>) {
//        RESERVATION_DATE_REF.child(date).child(ID).removeValue { (error, ref) in
//            self.modifyReservationDate(newDate: date, reservationId: ID, with: <#T##Dictionary<String, Any>#>)
//        }
//    }
    
    
    //    MARK: - VerifictionVC
    
    func observeChildRemoved(for reference: DatabaseReference, completed: @escaping(Result<DataSnapshot, JWError>) -> Void) {
        reference.observe(.childRemoved) { (snapshot) in
            completed(.success(snapshot))
        }
    }
    

    func deletePendingWaiver(withImage condition: Bool, imageURL: String?, forWaiver waiverID: String) {
        
        if condition {
            PARTICIPANT_WAIVER_REF.child(waiverID).removeValue { (err, ref) in
                WAIVER_IMAGE_REF.child(waiverID).delete(completion: nil)
            }
            
        } else {
            PARTICIPANT_WAIVER_REF.child(waiverID).removeValue()
        }
    }
    
    
    func fetchApprovedWaivers(quantity value: Int, startAt: String, completed: @escaping(Result<ApprovedWaiver, JWError>) -> Void) {
        APPROVED_WAIVER_REF.queryOrdered(byChild: Constant.fullNameReversed).queryLimited(toFirst: UInt(value)).queryStarting(atValue: startAt).observeSingleEvent(of: .value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach { (snapshot) in
                    
                    let waiverID = snapshot.key
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    let waiver = ApprovedWaiver(waiverID: waiverID, dictionary: dictionary)
                    completed(.success(waiver))
                }
            }
        }
    }
    
    
    func searchApprovedWaivers(completed: @escaping(Result<ApprovedWaiver, JWError>) -> Void) {
        APPROVED_WAIVER_REF.observeSingleEvent(of: .value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach { (snapshot) in
                    
                    let waiverID = snapshot.key
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    let waiver = ApprovedWaiver(waiverID: waiverID, dictionary: dictionary)
                    completed(.success(waiver))
                }
            }
        }
    }
    
    
    func fetchPendingWaivers(completed: @escaping(Result<WaiverVerification, JWError>) -> Void) {
        PARTICIPANT_WAIVER_REF.observe(.value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach { (snapshot) in
                    
                    let waiverID = snapshot.key
                    
                    guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                    let waiver = WaiverVerification(waiverID: waiverID, dictionary: dictionary)
                    completed(.success(waiver))
                }
            }
        }
    }
    
    
    //    MARK: - WaiverVC
    
    
    func deleteCompletedReservation(for reservationID: String, date day: String, completed: @escaping(Result<Bool?, JWError>) -> Void) {
         RESERVATION_REF.child(reservationID).removeValue { (error, ref) in
             
             if let _ = error {
                 completed(.failure(.reservationLimit))
                 return
             }else {
                 RESERVATION_DATE_REF.child(day).child(reservationID).removeValue()
                 completed(.success(true))
             }
         }
     }
    
    
    func postEmail(with waiverID: String, values: Dictionary<String, Any>) {
        PARTICIPANT_EMAIL_REF.child(waiverID).updateChildValues(values)
    }
    
    
    func postWaiver(with values: Dictionary<String, Any>, waiver: DatabaseReference? ,completed: @escaping(Result<DatabaseReference, JWError>) -> Void) {
        
        var waiverID: DatabaseReference!
        
        if let currentID = waiver {
            waiverID = currentID
        } else {
            waiverID = PARTICIPANT_WAIVER_REF.childByAutoId()
        }
        
        waiverID.updateChildValues(values) { (error, ref) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                completed(.success(waiverID))
            }
        }
    }
    
    
    func postCompletedWaiver(with image: Data, completed: @escaping(Result<Dictionary <DatabaseReference, String>, JWError>) -> Void) {
        
        let waiverID = PARTICIPANT_WAIVER_REF.childByAutoId()
        WAIVER_IMAGE_REF.child("\(waiverID)").putData(image, metadata: nil) { (metadata, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                
                WAIVER_IMAGE_REF.child("\(waiverID)").downloadURL { (url, error) in
                    
                    if let _ = error {
                        completed(.failure(.unableToCompleteRequest))
                        return
                    } else {
                        
                        guard let url = url?.absoluteString else { completed(.failure(.unableToCompleteRequest))
                            return
                        }
                        
                        let value = [waiverID : url]
                        completed(.success(value))
                    }
                }
            }
        }
    }
    
    
    func updatePaxCount(for reservationID: String, pax value: Int) {
        RESERVATION_REF.child(reservationID).child(Constant.paxCount).setValue(value)
    }
    

    
}

