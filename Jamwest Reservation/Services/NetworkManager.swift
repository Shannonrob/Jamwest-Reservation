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
    
    
    func fetchReservation(completed: @escaping (Result<EditReservation, JWError>) -> Void) {
        RESERVATION_REF.observe(.value) { (snapshot, error) in
            
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
    
    
    func removeReservation(for id: String, caseType: ShowInformation, completed: @escaping (Result<String?, JWError>) -> Void) {
        let reference: DatabaseReference!
        
        switch caseType {
        case .EditReservation:
            reference = RESERVATION_REF
        case .EmailList:
            reference = PARTICIPANT_EMAIL_REF
        }
        
        reference.child(id).removeValue { (error, ref) in
            if let _ = error {
                completed(.failure(.malfunction))
            } else {
                completed(.success(.none))
            }
        }
    }
    
    
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
    
    
    //    MARK: - HomeVC
    
    func fetchReservations(for date: String, completed: @escaping (Result<Reservation, JWError>) -> Void) {
        
        RESERVATION_REF.queryOrdered(byChild: Constant.reservationDate).queryEqual(toValue: date).observe(.value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            }else {
                
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else {
                    completed(.failure(.malfunction))
                    return
                }
                
                allObjects.forEach { (snapshot) in
                    
                    let reservationID = snapshot.key
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
    
    
    func checkReservationsEmptyState(for date: String, completed: @escaping (Result<DataSnapshot, JWError>) -> Void) {
        
        RESERVATION_REF.queryOrdered(byChild: Constant.reservationDate).queryEqual(toValue: date).observeSingleEvent(of: .value) { (snapShot, error) in
            
            if let _ = error {
                completed(.failure(.malfunction))
                return
            } else {
                completed(.success(snapShot))
            }
        }
    }
    
    
    func observeReservationDeleted(for date: String, completed: @escaping (Result<String?, JWError>) -> Void) {
        
        RESERVATION_REF.queryOrdered(byChild: Constant.reservationDate).queryEqual(toValue: date).observe(.childRemoved) { (snapshot, err) in
          
            if let _ = err {
                completed(.failure(.malfunction))
            } else {
                completed(.success(.none))
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
    
    func createReservation(with values: Dictionary<String, Any>, completed: @escaping (Result<String? ,JWError>) -> Void) {
        let reservation = RESERVATION_REF.childByAutoId()
        reservation.updateChildValues(values) { (err, ref) in
            
            if let _ = err {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                completed(.success(.none))
            }
        }
    }
    
    
    func updateReservation(for reservation: String, values: Dictionary<String, Any>, completed: @escaping (Result<String? ,JWError>) -> Void) {
        
        RESERVATION_REF.child(reservation).updateChildValues(values) { (error, ref) in
            if let _ = error {
                completed(.failure(.unableToCompleteRequest))
                return
            } else {
                completed(.success(.none))
            }
        }
    }
    
    
    //    MARK: - VerifictionVC
    
    func observeWaiverDeletion(for reference: DatabaseReference, completed: @escaping(Result<DataSnapshot?, JWError>) -> Void) {
        reference.observe(.childRemoved) { (snapshot) in
            completed(.success(snapshot))
        }
    }
    
    
    func fetchApprovedWaivers(quantity value: Int, startAt: String, completed: @escaping(Result<ApprovedWaiver, JWError>) -> Void) {
        APPROVED_WAIVER_REF.queryOrdered(byChild: Constant.lastName).queryLimited(toFirst: UInt(value)).queryStarting(atValue: startAt).observeSingleEvent(of: .value) { (snapshot, error) in
            
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
}

