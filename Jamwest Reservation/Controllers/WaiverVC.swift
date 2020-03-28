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
     
//        print("scroll view containter width is\(waiverViews.scrollViewContainer.frame.width)")
//        print("scroll view height is\(waiverViews.scrollView.contentSize.height)")
//        print("containerView height is\(waiverViews.containerView.frame)")
//        print("textView height is\(waiverViews.textView.contentSize.height)")
//        print("headerImage height is\(waiverViews.headerImage.frame.height)")
        
//        print("scrollView content size is \(waiverViews.scrollView.contentSize)")
//        print("scrollView page size width is \(waiverViews.scrollView.bounds.size.width)")
//        print("scrollView total size width is \(waiverViews.scrollView.contentSize.width)")
//        print("scrollView page height is \(waiverViews.scrollView.bounds.size.height)")
//        print("scrollView total height is \(waiverViews.scrollView.contentSize.height)")
//
        print("total containerView width \(waiverViews.containerView.frame.width)")
        print("total containerView height \(waiverViews.containerView.frame.height)")
        print("containerView bounds \(waiverViews.containerView.bounds)")
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
