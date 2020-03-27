//
//  WaiverVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class WaiverVC: UIViewController {
    
//    MARK: - Properties
    var waiverViews = WaiverViews()
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
//        print("scroll view containter height is\(waiverViews.scrollViewContainer.frame.height)")
//        print("scroll view height is\(waiverViews.scrollView.contentSize.height)")
//        print("containerView height is\(waiverViews.containerView.frame)")
//        print("textView height is\(waiverViews.textView.contentSize.height)")
//        print("headerImage height is\(waiverViews.headerImage.frame.height)")
    }
    
    override func loadView() {
        
//        participantInfoView.participantInfoDelegate = self
        view = waiverViews
    }
    
//    MARK: - Selectors
  
//    MARK:- Helper Functions
    
    func configureUI() {
        
         view.backgroundColor = Constants.Design.Color.Background.FadeGray
    }
}
