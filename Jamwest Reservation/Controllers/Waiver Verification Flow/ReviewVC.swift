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
    func handleDismissButtonTapped(for vc: ReviewView) {
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: - Helper function
    
    func presentData() {
        
        var tours = String()
        
        guard let name = waivers?.name,
        let image = waivers?.imageURL,
        let pregnantAnswer = waivers?.pregnantAnswer,
        let minorAnswer = waivers?.minorAnswer,
        let influenceAnswer = waivers?.underInfluenceAnswer,
        let heartAnswer = waivers?.heartAnswer,
        let backAnswer = waivers?.backAnswer else { return }
        
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
        waiverReviewView.profileImageView.loadImage(with: image)
        waiverReviewView.nameLabel.text = name
        waiverReviewView.toursLabel.text = tours
        waiverReviewView.pregnantLabel.attributedText = UILabel.configureAttributes(with: "Pregnant: ", append: "\(newPregnantAnswer)")
        waiverReviewView.minorAnswerLabel.attributedText = UILabel.configureAttributes(with: "Minor: ", append: "\(newMinorAnswer)")
        waiverReviewView.influenceLabel.attributedText = UILabel.configureAttributes(with: "Under influence: ", append: "\(newInfluenceAnswer)")
        waiverReviewView.heartProblemLabel.attributedText = UILabel.configureAttributes(with: "Heart problem: ", append: "\(newHeartAnswer)")
        waiverReviewView.backProblemLabel.attributedText = UILabel.configureAttributes(with: "Back problem: ", append: "\(newBackAnswer)")
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
