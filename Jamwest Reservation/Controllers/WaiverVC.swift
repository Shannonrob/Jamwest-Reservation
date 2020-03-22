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
    
    
//    MAR: - UIViews
    
    let scrollView = JamwestDefaultView()
    let signatureContentsView = JamwestDefaultView()
 
    let signatureView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        return view
    }()
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
        configureContraints()
    }
    
//    MARK: - Selectors
    
    
    
//    MARK:- Helper Functions
    
    func configureUI() {
        
         view.backgroundColor = Constants.Design.Color.Background.FadeGray
         
         navigationItem.title = "Terms and Conditions"
         navigationController?.navigationBar.isTranslucent = false
         navigationController?.navigationBar.barStyle = .black
         navigationController?.navigationBar.barTintColor = Constants.Design.Color.Primary.HeavyGreen
         
         let navigationFont = UIFont.boldSystemFont(ofSize: 25)
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationFont]
    }
    
    func configureContraints() {
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 400)
        
        view.addSubview(signatureContentsView)
        signatureContentsView.anchor(top: scrollView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 25, paddingBottom: 25, paddingRight: 25, width: 0, height: 0)
        
        view.addSubview(signatureView)
        signatureView.anchor(top: signatureContentsView.topAnchor, left: signatureContentsView.leftAnchor, bottom: nil, right: signatureContentsView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 180)
    }
}
