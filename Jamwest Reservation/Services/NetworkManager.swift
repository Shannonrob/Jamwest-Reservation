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
    
    
    //    MARK: - ReviewVC Network Calls
    
    func updateWaiver(with image: UIImage, waiverID: String, completed: @escaping (Result <String?, JWError>) -> Void) {
        guard let uploadData = image.jpegData(compressionQuality: 0.75) else { return }
        
        WAIVER_IMAGE_REF.child(waiverID).putData(uploadData, metadata: nil) { [weak self] (metadata, error) in
            guard let _ = self else { return }
            
            if let _ = error { completed(.failure(.unableToComplete))
                return
            }
            
            // download image url
            WAIVER_IMAGE_REF.child(waiverID).downloadURL { (url, error) in
                
                if let _ = error { completed(.failure(.unableToComplete))
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
                completed(.failure(.unableToComplete))
                return
            } else {
                completed(.success(waiverID))
            }
        }
    }
    
    
    //    MARK: - VerifictionVC Network Calls
    
    func observeWaiverDeletion(completed: @escaping(Result<WaiverVerification?, JWError>) -> Void) {
        PARTICIPANT_WAIVER_REF.observe(.childRemoved) { (snapshot) in
            completed(.success(nil))
        }
    }
    
    func fetchApprovedWaivers(completed: @escaping(Result<ApprovedWaiver, JWError>) -> Void) {
        APPROVED_WAIVER_REF.observe(.childAdded) { (snapshot) in
            
            let waiverID = snapshot.key
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let waiver = ApprovedWaiver(waiverID: waiverID, dictionary: dictionary)
            completed(.success(waiver))
        }
    }
    
    func fetchPendingWaivers(completed: @escaping(Result<WaiverVerification, JWError>) -> Void) {
        PARTICIPANT_WAIVER_REF.observe(.value) { (snapshot, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
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
}
