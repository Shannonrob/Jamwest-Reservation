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
    
    let navigationBarView: UIView = {
        
        let view = UIView()
        view.backgroundColor = Constants.Design.Color.Primary.HeavyGreen
        return view
    }()
    
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
    
    let navigationBarTitle: UILabel = {
        
        let label = UILabel()
        label.text = "Waiver & Release of Liability"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
//    MARK: - UITextView
    
    lazy var textView: UITextView = {
        
        let textView = UITextView()
        let url = Bundle.main.url(forResource: "JamwestWaiver", withExtension: "rtf")!
        let opts : [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.rtf]
        var dictionary: NSDictionary? = nil
        let waiverText = try! NSAttributedString(url: url, options: opts, documentAttributes: &dictionary)
        
        textView.backgroundColor = .clear
        textView.textColor = .darkText
        textView.isEditable = false
        textView.font = UIFont.init(name: helveticaNeue_Medium, size: 18)
        textView.textAlignment = .center
        textView.attributedText = waiverText
        return textView
    }()
    
    
//    MARK: - Constraints
    
    func configureConstraints() {
        
        addSubview(navigationBarView)
        navigationBarView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70)
        
        navigationBarView.addSubview(navigationBarTitle)
        navigationBarTitle.anchor(top: navigationBarView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        navigationBarTitle.centerXAnchor.constraint(equalTo: navigationBarView.centerXAnchor).isActive = true
        navigationBarTitle.centerYAnchor.constraint(equalTo: navigationBarView.centerYAnchor).isActive = true
        
        addSubview(scrollViewContainer)
        scrollViewContainer.anchor(top: navigationBarView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)

        scrollViewContainer.addSubview(scrollView)
        scrollView.anchor(top: scrollViewContainer.topAnchor, left: scrollViewContainer.leftAnchor, bottom: scrollViewContainer.bottomAnchor, right: scrollViewContainer.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)

        scrollView.addSubview(containerView)
        containerView.anchor(top: nil, left: scrollView.frameLayoutGuide.leftAnchor, bottom: nil, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: scrollView.frame.width, height: scrollView.frame.height + 5000)

        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 10, width: 20, height: 0)
        
//        view.addSubview(signatureView)
//        signatureView.anchor(top: signatureContentsView.topAnchor, left: signatureContentsView.leftAnchor, bottom: nil, right: signatureContentsView.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 180)
        
    }

}
