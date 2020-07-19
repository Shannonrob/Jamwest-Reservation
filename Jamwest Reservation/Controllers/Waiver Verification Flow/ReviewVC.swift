//
//  WaiverReviewVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class ReviewVC: UIViewController, ReviewWaiverDelegate {
    
//   MARK: - Properties
    
    var waivers: WaiverVerification?
    var waiverReviewView = ReviewView()
    var verificationVC: VerificationVC?
    
//    MARK: - Init
    
    override func loadView() {
        super.loadView()
        view = waiverReviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waiverReviewView.reviewWaiverDelegate = self
        presentData()
    }
    
    //    MARK: - Protocol and delegate
    
    func handleRejectButton(for vc: ReviewView) {
        rejectWaiver()
    }
    
    func handleApproveButton(for vc: ReviewView) {
        approveWaiver()
    }
    
    func handleCameraButton(for vc: ReviewView) {
        verificationVC?.inSearchMode == true ? verificationVC?.handleCancelSearch() : nil
        presentCamera()
    }
    
    func handleDismissButtonTapped(for vc: ReviewView) {
        dismiss(animated: true, completion: nil)
    }
    
    //    MARK: - Helper function
    
    func presentData() {
        
        var tours = String()
        
        guard let firstName = waivers?.firstName,
            let lastName = waivers?.lastName,
            let pregnantAnswer = waivers?.pregnantAnswer,
            let minorAnswer = waivers?.minorAnswer,
            let influenceAnswer = waivers?.underInfluenceAnswer,
            let heartAnswer = waivers?.heartAnswer,
            let backAnswer = waivers?.backAnswer else { return }
        
        // check if image exist else use avatar image
        if let image = waivers?.imageURL {
            waiverReviewView.profileImageView.loadImage(with: image)
        } else {
            waiverReviewView.profileImageView.image = #imageLiteral(resourceName: "gray_Avatar ").withRenderingMode(.alwaysOriginal).withTintColor(.white)
        }
        
        // check if tours are nill and append it to tours array
        if let firstTour = waivers?.firstTour { tours.append(firstTour) }
        if let secondTour = waivers?.secondTour { tours.append("| \(secondTour)") }
        if let thirdTour = waivers?.thirdTour { tours.append("| \(thirdTour)") }
        if let fourthTour = waivers?.fourthTour { tours.append("| \(fourthTour)") }
        
        // convert boolean answers to string
        let newPregnantAnswer = updateAnswerValue(with: pregnantAnswer)
        let newMinorAnswer = updateAnswerValue(with: minorAnswer)
        let newInfluenceAnswer = updateAnswerValue(with: influenceAnswer)
        let newHeartAnswer = updateAnswerValue(with: heartAnswer)
        let newBackAnswer = updateAnswerValue(with: backAnswer)
        
        // update imageView and labels with data
        waiverReviewView.firstNameLabel.text = firstName
        waiverReviewView.lastNameLabel.text = lastName
        waiverReviewView.toursLabel.text = tours
        waiverReviewView.pregnantLabel.attributedText = UILabel.configureAttributes(with: "Pregnant: ", append: "\(newPregnantAnswer)")
        waiverReviewView.minorAnswerLabel.attributedText = UILabel.configureAttributes(with: "Minor: ", append: "\(newMinorAnswer)")
        waiverReviewView.influenceLabel.attributedText = UILabel.configureAttributes(with: "Under influence: ", append: "\(newInfluenceAnswer)")
        waiverReviewView.heartProblemLabel.attributedText = UILabel.configureAttributes(with: "Heart problem: ", append: "\(newHeartAnswer)")
        waiverReviewView.backProblemLabel.attributedText = UILabel.configureAttributes(with: "Back problem: ", append: "\(newBackAnswer)")
    }
    
    // handles deletions of waiver
    func rejectWaiver() {
        
        let alertController = UIAlertController(title: "Warning", message: ErrorMessage.waiverDeleteWarning, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Continue", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            
            self.dismiss(animated: true) {
                
                self.cancelSearchMode()
                
                if self.waivers?.imageURL != nil {
                    
                    self.waivers?.deletePendingWaiver(id: self.waivers!.waiverID, withImage: true)
                } else {
                    self.waivers?.deletePendingWaiver(id: self.waivers!.waiverID, withImage: false)
                }
            }
        })
        
        let deleteAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(deleteAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // method to convert answer to string
    func updateAnswerValue(with answer: Bool) -> String {
        
        if answer {
            return "Yes"
        } else {
            return "No"
        }
    }
    
    // cancels search mode for VerificationVC
    func cancelSearchMode() {
       
        if verificationVC?.inSearchMode == true {
            verificationVC?.handleCancelSearch()
        }
    }
    
//    MARK: - Api
    
    func updateParticipantProfile(with image: UIImage) {
        
        guard let waiverID = self.waivers?.waiverID else { return }
        NetworkManager.shared.updateWaiver(with: image, waiverID: waiverID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageURL):
                guard let imageURL = imageURL else { return }
                self.waivers?.imageURL = imageURL
        
            case .failure(let error):
                DispatchQueue.main.async {
                    Alert.showAlert(on: self, with: error.rawValue)
                }
            }
        }
    }
    
    func approveWaiver() {
        guard let creationDate = Date.CurrentDate(),
            let firstName = waivers?.firstName,
            let lastName = waivers?.lastName,
            let waiverID = waivers?.waiverID else {
                Alert.showAlert(on: self, with: ErrorMessage.minorError)
                return
        }
        
        guard let image = waivers?.imageURL else {
            Alert.showRequiredMessage(on: self, with: ErrorMessage.photoRequired)
            return
        }
        
        // append values
        var values = [String:Any]()
        values[Constant.firstName] = firstName
        values[Constant.lastName] = lastName
        values[Constant.imageURL] = image
        values[Constant.creationDate] = creationDate
        
        showLoadingView()
        NetworkManager.shared.approveWaiver(for: waiverID, with: values) { [weak self] (result) in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let waiverID):
                self.dismiss(animated: true)
                
                DispatchQueue.global(qos: .background).async {
                    self.waivers?.deletePendingWaiver(id: waiverID, withImage: true)
                }
                self.cancelSearchMode()
                
            case .failure(let error):
                DispatchQueue.main.async {
                    Alert.showAlert(on: self, with: error.rawValue)
                }
            }
        }
    }
}

extension ReviewVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.cameraDevice = .rear
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            Alert.showAlert(on: self, with: ErrorMessage.minorError)
            return
        }
        updateParticipantProfile(with: image)
        waiverReviewView.profileImageView.image = image.withRenderingMode(.alwaysOriginal)
    }
}

