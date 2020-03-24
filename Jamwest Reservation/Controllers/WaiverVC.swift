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
        print(waiverViews.firstTextView.contentSize)
    }
    
    override func loadView() {
        
//        participantInfoView.participantInfoDelegate = self
        view = waiverViews
    }
    
//    MARK: - Selectors
  
//    MARK:- Helper Functions
    
    func configureUI() {
        
         view.backgroundColor = Constants.Design.Color.Background.FadeGray
         
         navigationItem.title = "Waiver & Release of Liability"
         navigationController?.navigationBar.isTranslucent = false
         navigationController?.navigationBar.barStyle = .black
         navigationController?.navigationBar.barTintColor = Constants.Design.Color.Primary.HeavyGreen
         
         let navigationFont = UIFont.boldSystemFont(ofSize: 25)
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationFont]
    }
}
