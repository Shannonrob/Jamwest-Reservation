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
    
    lazy var contentViewSize = CGSize(width: self.scrollViewContainer.frame.width, height: self.scrollViewContainer.frame.height + 2000 )
    
//    MARK: - ScrollView
    
    lazy var scrollView: UIScrollView = {
        
        let view = UIScrollView()
        view.backgroundColor = Constants.Design.Color.Background.FadeGray
        view.contentSize = contentViewSize
        view.alwaysBounceVertical = true
        return view
    }()
    
//    MARK: - UIViews
    
    let signatureContentsView = JamwestDefaultView()
    
    // the view holding the scrollView
    let scrollViewContainer = JamwestDefaultView()
    
    let containerView: UIView = {
        // the view inside the scrollView
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
 
    let signatureView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        return view
    }()
    

    
//    MARK: - UILabel
    
    let testLabel = TestLabel()
    
//    lazy var testLabel: UILabel = {
//
//        let label = UILabel()
//        label.labelConfigurations(text: "Keep Trying", textColor: .black, fontSize: 30)
//        label.contentMode = .center
//        label.frame = self.containerView.frame
//        return label
//    }()
    
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
        
        view.addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 400)
        

        scrollViewContainer.addSubview(scrollView)
        scrollView.anchor(top: scrollViewContainer.topAnchor, left: scrollViewContainer.leftAnchor, bottom: scrollViewContainer.bottomAnchor, right: scrollViewContainer.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)

        scrollView.addSubview(containerView)
        containerView.anchor(top: nil, left: scrollView.frameLayoutGuide.leftAnchor, bottom: nil, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: scrollView.frame.width, height: scrollView.frame.height + 2000)

        containerView.addSubview(testLabel)
        testLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0, height: 0)


        
        
//        view.addSubview(signatureView)
//        signatureView.anchor(top: signatureContentsView.topAnchor, left: signatureContentsView.leftAnchor, bottom: nil, right: signatureContentsView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 180)
    }
}
