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
    var reviewWaiverDelegate: ReviewWaiverDelegate?
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - View
    
    let waiverView = JamwestDefaultView()
    
    //    MARK: - ImageView
    
    let profileImageView: CustomImageView = {
        
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 192 / 2
        imageView.backgroundColor = .lightGray
        imageView.layer.borderWidth = 5.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    //    MARK: - labels
    
    let firstNameLabel: UILabel = {

        let label = UILabel()
        label.text = "First Name"
        label.textColor = .darkGray
        label.font = UIFont.init(name: Font.helveticaNeueBold, size: 18)
        return label
    }()
    
    let lastNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Last Name"
        label.textColor = .darkGray
        label.font = UIFont.init(name: Font.helveticaNeueBold, size: 18)
        return label
    }()
    
    let tourHeaderLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Tours"
        label.textColor = .darkGray
        label.font = UIFont.init(name: Font.helveticaNeueBold, size: 20)
        return label
    }()
    
    let toursLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Tours"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let pregnantLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Pregnant answer"
        label.textColor = .black
        label.font = UIFont.init(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    let minorAnswerLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Minor answer"
        label.textColor = .black
        label.font = UIFont.init(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    let influenceLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Under influence answer"
        label.textColor = .black
        label.font = UIFont.init(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    let heartProblemLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Heart answer"
        label.textColor = .black
        label.font = UIFont.init(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    let backProblemLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Back problem answer"
        label.textColor = .black
        label.font = UIFont.init(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    //    MARK: - Buttons
    
    lazy var cameraButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "greenCamera").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addShadow()
        button.addTarget(self, action: #selector(handleCameraTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var rejectButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButtonWithIcon(nil, title: "Reject", titleColor: .black, buttonColor: Color.Background.fadeGray, cornerRadius: 8)
        button.titleLabel?.font = UIFont.init(name: Font.avenirNextDemibold, size: 19)
        button.addShadow()
        button.addTarget(self, action: #selector(handleRejectButton), for: .touchUpInside)
        return button
    }()
    
    lazy var approveButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButtonWithIcon(nil, title: "Approve", titleColor: .white, buttonColor: Color.Primary.orange, cornerRadius: 8)
        button.titleLabel?.font = UIFont.init(name: Font.avenirNextDemibold, size: 19)
        button.addShadow()
        button.addTarget(self, action: #selector(handleApproveButton), for: .touchUpInside)
        return button
    }()
    
    // this button is temporary while working on the project, afterwards the screen will be swipe down to delete 
    lazy var dismissButton: UIButton = {
        
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "grayClearButtonMedium").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitleColor(Color.Primary.markerColor, for: .normal)
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    //    MARK: - Handlers
    
    @objc func handleDismissButton() {
        reviewWaiverDelegate?.handleDismissButtonTapped(for: self)
    }
    
    
//    MARK: - Protocols
    
    @objc func handleRejectButton() {
        reviewWaiverDelegate?.handleRejectButton(for: self)
    }
    
    @objc func handleApproveButton() {
        reviewWaiverDelegate?.handleApproveButton(for: self)
    }
    
    @objc func handleCameraTapped() {
        reviewWaiverDelegate?.handleCameraButton(for: self)
    }
    
    //    MARK: - Helper Functions
    
    func configureConstraints() {
        
        let participantNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel])
        participantNameStackView.configureStackView(alignment: .fill, distribution: .equalSpacing, spacing: 8)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [rejectButton, approveButton])
        buttonsStackView.configureStackView(alignment: .fill, distribution: .fillEqually, spacing: 10)
        
        let leftAnswersStackView = UIStackView(arrangedSubviews: [minorAnswerLabel, pregnantLabel, influenceLabel])
        leftAnswersStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 10)
        leftAnswersStackView.axis = .vertical
        
        let rightAnswersStackView = UIStackView(arrangedSubviews: [heartProblemLabel, backProblemLabel])
        rightAnswersStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 10)
        rightAnswersStackView.axis = .vertical
        
        let answerStackView = UIStackView(arrangedSubviews: [leftAnswersStackView, rightAnswersStackView])
        answerStackView.configureStackView(alignment: .top, distribution: .equalCentering, spacing: 60)
        
        addSubview(waiverView)
        waiverView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 640, height: 470)
        waiverView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        waiverView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 80).isActive = true
        
        waiverView.addSubview(cameraButton)
        cameraButton.anchor(top: waiverView.topAnchor, left: nil, bottom: nil, right: waiverView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        
        waiverView.addSubview(profileImageView)
        profileImageView.anchor(top: waiverView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: -96, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 192, height: 192)
        profileImageView.centerXAnchor.constraint(equalTo: waiverView.centerXAnchor).isActive = true
        
        waiverView.addSubview(participantNameStackView)
        participantNameStackView.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        participantNameStackView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        
        waiverView.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: participantNameStackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 280, height: 45)
        buttonsStackView.centerXAnchor.constraint(equalTo: participantNameStackView.centerXAnchor).isActive = true
        
        waiverView.addSubview(dismissButton)
        dismissButton.anchor(top: waiverView.topAnchor, left: waiverView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dismissButton.centerYAnchor.constraint(equalTo: cameraButton.centerYAnchor).isActive = true
        
        waiverView.addSubview(tourHeaderLabel)
        tourHeaderLabel.anchor(top: buttonsStackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 35, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tourHeaderLabel.centerXAnchor.constraint(equalTo: buttonsStackView.centerXAnchor).isActive = true
        
        waiverView.addSubview(toursLabel)
        toursLabel.anchor(top: tourHeaderLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        toursLabel.centerXAnchor.constraint(equalTo: tourHeaderLabel.centerXAnchor).isActive = true
        
        waiverView.addSubview(answerStackView)
        answerStackView.anchor(top: toursLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        answerStackView.centerXAnchor.constraint(equalTo: tourHeaderLabel.centerXAnchor).isActive = true
    }
}
