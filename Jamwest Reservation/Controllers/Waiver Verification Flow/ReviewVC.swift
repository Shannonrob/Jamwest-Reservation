//
//  WaiverReviewVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController {
    
    // array of custom object
    var waivers: WaiverVerification?
    var waiverReviewView = ReviewView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = waiverReviewView
        presentData()
        
        print(waivers?.name)
        print(waivers?.pregnantAnswer)
        print(waivers?.minorAnswer)
        print(waivers?.underInfluenceAnswer)
        print(waivers?.heartAnswer)
        print(waivers?.backAnswer)
        
        
    }
    
    func presentData() {
        
        guard let name = waivers?.name,
//        let image = waivers?.imageURL,
        let pregnantAnswer = waivers?.pregnantAnswer,
        let minorAnser = waivers?.minorAnswer,
        let underInfluenceAnswer = waivers?.underInfluenceAnswer,
        let heartAnswer = waivers?.heartAnswer,
        let backAnser = waivers?.backAnswer else { return }
        
        waiverReviewView.nameLabel.text = name
    }
}
