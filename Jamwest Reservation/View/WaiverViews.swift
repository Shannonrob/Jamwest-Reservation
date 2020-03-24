//
//  WaiverViews.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/23/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class WaiverViews: UIView {

//    MARK: - Properties
    
    lazy var contentViewSize = CGSize(width: self.scrollViewContainer.frame.width, height: self.scrollViewContainer.frame.height + 7000 )
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // initialize constraints/views here
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UIViews
    
    let scrollViewContainer = JamwestDefaultView()
    let signatureContentsView = JamwestDefaultView()
    
    lazy var scrollView: UIScrollView = {
        
        let view = UIScrollView()
        view.backgroundColor = .white
        view.contentSize = contentViewSize
        view.alwaysBounceVertical = true
        view.indicatorStyle = .black
        return view
    }()
    
    let containerView: UIView = {
        // the view inside the scrollView
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    let signatureView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        return view
    }()
    
//    MARK: - UILabels
//    let testLabel = TestLabel()
    
    let firstBoldLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.font = UIFont.init(name: helveticaNeue_Bold, size: 14)
        label.text = "WARNING, ASSUMPTION OF RISK, LIABILITY RELEASE, INDEMNITY AND HOLD HARMLESS AGREEMENT"
        return label
    }()
    
    let secondBoldLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.attributedText = NSAttributedString(string: "PLEASE READ CAREFULLY BEFORE SIGNING.", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: UIColor.red])
        return label
    }()
    
    let thirdBoldLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "This is a release of liability and waiver of legal rights."
        label.font = UIFont.init(name: helveticaNeue_Bold, size: 20)
        return label
    }()
    
    let fourthBoldLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "ATV, PUSH KART, GO KART AND DRIVING EXPERIENCE"
        label.textAlignment = .left
        label.font = UIFont.init(name: helveticaNeue_Bold, size: 20)
        return label
    }()
    
    
    
//    MARK: - UITextView
    
    let firstTextView: UITextView = {
        
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.font = UIFont.init(name: helveticaNeue_Medium, size: 18)
        textView.textAlignment = .natural
        textView.text = firstWaiverText
        return textView
    }()
    
    let secondTextView: UITextView = {
        
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.font = UIFont.init(name: helveticaNeue_Medium, size: 18)
        textView.textAlignment = .natural
        textView.text = secondWaiverText
        return textView
    }()
    
    
//    MARK: - Constraints
    
    func configureConstraints() {
        
        let secondHeaderLabels = UIStackView(arrangedSubviews: [secondBoldLabel, thirdBoldLabel])
        secondHeaderLabels.configureStackView(alignment: .center, distribution: .fillEqually, spacing: 5)
        secondHeaderLabels.axis = .vertical
        
        
        addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        scrollViewContainer.addSubview(scrollView)
        scrollView.anchor(top: scrollViewContainer.topAnchor, left: scrollViewContainer.leftAnchor, bottom: scrollViewContainer.bottomAnchor, right: scrollViewContainer.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        scrollView.addSubview(containerView)
        containerView.anchor(top: nil, left: scrollView.frameLayoutGuide.leftAnchor, bottom: nil, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: scrollView.frame.width, height: scrollView.frame.height + 5000)
        
        containerView.addSubview(firstBoldLabel)
        firstBoldLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
        containerView.addSubview(secondHeaderLabels)
        secondHeaderLabels.anchor(top: firstBoldLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        containerView.addSubview(firstTextView)
        firstTextView.anchor(top: secondHeaderLabels.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 820)

        containerView.addSubview(fourthBoldLabel)
        fourthBoldLabel.anchor(top: firstTextView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 25, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        containerView.addSubview(secondTextView)
        secondTextView.anchor(top: fourthBoldLabel.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
//
//        view.addSubview(signatureView)
//        signatureView.anchor(top: signatureContentsView.topAnchor, left: signatureContentsView.leftAnchor, bottom: nil, right: signatureContentsView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 180)
        
    }

}
