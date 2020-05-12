//
//  WaiverReviewVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController, ReviewWaiverDelegate {
    
    // array of custom object
    var waivers: WaiverVerification?
    var waiverReviewView = ReviewView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = waiverReviewView
        waiverReviewView.reviewWaiverDelegate = self
        presentData()
    }
    
//    MARK: - Protocol and delegate
    
    func handleRejectButton(for vc: ReviewView) {
        rejectWaiver()
    }
    
    func handleApproveButton(for vc: ReviewView) {
        print("Approve button tapped")
    }
    
    func handleEditButton(for vc: ReviewView) {
        print("Edit button tapped")
    }
    
    func handleDismissButtonTapped(for vc: ReviewView) {
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: - Helper function
    
    func presentData() {
        
        var tours = String()
        
        guard let name = waivers?.name,
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
        waiverReviewView.nameLabel.text = name
        waiverReviewView.toursLabel.text = tours
        waiverReviewView.pregnantLabel.attributedText = UILabel.configureAttributes(with: "Pregnant: ", append: "\(newPregnantAnswer)")
        waiverReviewView.minorAnswerLabel.attributedText = UILabel.configureAttributes(with: "Minor: ", append: "\(newMinorAnswer)")
        waiverReviewView.influenceLabel.attributedText = UILabel.configureAttributes(with: "Under influence: ", append: "\(newInfluenceAnswer)")
        waiverReviewView.heartProblemLabel.attributedText = UILabel.configureAttributes(with: "Heart problem: ", append: "\(newHeartAnswer)")
        waiverReviewView.backProblemLabel.attributedText = UILabel.configureAttributes(with: "Back problem: ", append: "\(newBackAnswer)")
    }
    
    // handles deletions of waiver
    func rejectWaiver() {
        
        let alertController = UIAlertController(title: "Warning", message: "Waiver will be deleted!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Continue", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            
            self.dismiss(animated: true) {
                self.waivers?.rejectWaiver(id: self.waivers!.waiverID)
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
}
