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
        
        guard let name = waivers?.name,
        let image = waivers?.imageURL,
        let pregnantAnswer = waivers?.pregnantAnswer,
        let minorAnser = waivers?.minorAnswer,
        let influenceAnswer = waivers?.underInfluenceAnswer,
        let heartAnswer = waivers?.heartAnswer,
        let backAnswer = waivers?.backAnswer else { return }
        
        waiverReviewView.profileImageView.loadImage(with: image)
        waiverReviewView.nameLabel.text = name
        waiverReviewView.toursLabel.attributedText = UILabel.configureAttributes(with: "Tours: ", append: "Tours will be listed here!")
        waiverReviewView.pregnantLabel.attributedText = UILabel.configureAttributes(with: "Pregnant: ", append: "\(pregnantAnswer)")
        waiverReviewView.minorAnswerLabel.attributedText = UILabel.configureAttributes(with: "Minor: ", append: "\(minorAnser)")
        waiverReviewView.influenceLabel.attributedText = UILabel.configureAttributes(with: "Under influence: ", append: "\(influenceAnswer)")
        waiverReviewView.heartProblemLabel.attributedText = UILabel.configureAttributes(with: "Heart problem: ", append: "\(heartAnswer)")
        waiverReviewView.backProblemLabel.attributedText = UILabel.configureAttributes(with: "Back problem: ", append: "\(backAnswer)")
    }
}
