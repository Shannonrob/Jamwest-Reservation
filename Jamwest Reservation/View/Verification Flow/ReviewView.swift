//
//  WaiverReviewView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ReviewView: UIView {
    
//    MARK: - Properties

    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
//        backgroundColor = .clear
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - ImageView
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 192 / 2
        imageView.backgroundColor = .lightGray
        imageView.layer.borderWidth = 5.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

//    MARK: - View
    
    let waiverView: JamwestDefaultView = {
        
        let view = JamwestDefaultView()
        return view
    }()
    
//    MARK: - labels
    
    let nameLabel: JamwestWaiverLabelClass = {
        
        let label = JamwestWaiverLabelClass()
        label.text = "Test label"
        label.textColor = .black
        return label
    }()
    
    
//    MARK: - Helper Functions
    func configureConstraints() {
        
        addSubview(waiverView)
        waiverView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 740, height: 570)
        waiverView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        waiverView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 80).isActive = true
        
        waiverView.addSubview(profileImageView)
        profileImageView.anchor(top: waiverView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: -96, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 192, height: 192)
        profileImageView.centerXAnchor.constraint(equalTo: waiverView.centerXAnchor).isActive = true
        
        waiverView.addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true

        
//        addSubview(label)
//        label.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
