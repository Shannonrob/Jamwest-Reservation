//
//  WaiverVerificationCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/4/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class WaiverVerificationCell: UITableViewCell {
    
    //    MARK: - Properties

    var verificationCellDelegate: WaiverVerificationCellDelegate?
    
    var waiver: WaiverVerification? {
        
        didSet {
            
            var tours: String!
            
            guard let firstName = waiver?.firstName,
                let lastName = waiver?.lastName,
             let firstTour = waiver?.firstTour else { return }
            
            tours = firstTour
            
            if let participantImageUrl = waiver?.imageURL {
                participantImageView.loadImage(with: participantImageUrl)
                
            } else {
                participantImageView.image = #imageLiteral(resourceName: "gray_Avatar ").withRenderingMode(.alwaysOriginal).withTintColor(.white)
            }

            if let secondTour = waiver?.secondTour {
                tours.append(", \(secondTour)")
            }
            
            if let thirdTour = waiver?.thirdTour {
                tours.append(", \(thirdTour)")
            }
            
            if let fourthTour = waiver?.fourthTour {
                tours.append(", \(fourthTour)")
            }
           
            firstNameLabel.text = firstName
            lastNameLabel.text = lastName
            toursLabel.text = tours
        }
    }
    
    let cellView: UIView = {
        
        let view = UIView()
        view.addShadow()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        return view
    }()
    
    let participantImageView: CustomImageView = {
        
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 96 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //    MARK: - Label
    
    let firstNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "First Name"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let lastNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Last Name"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let toursLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Tours"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    //    MARK: - Button
    
    lazy var reviewButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButtonWithIcon(nil, title: "Review", titleColor: .black, buttonColor: Color.Background.fadeGray, cornerRadius: 8)
        button.titleLabel?.font = UIFont.init(name: Font.avenirNextDemibold, size: 18)
        button.addShadow()
        button.addTarget(self, action: #selector(handleReviewButton), for: .touchUpInside)
        return button
    }()
    
    lazy var approveButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButtonWithIcon(nil, title: "Approve", titleColor: .white, buttonColor: Color.Primary.orange, cornerRadius: 8)
        button.titleLabel?.font = UIFont.init(name: Font.avenirNextDemibold, size: 18)
        button.addShadow()
        button.addTarget(self, action: #selector(handleApproveButton), for: .touchUpInside)
        return button
    }()
    
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Handlers
    
    @objc func handleReviewButton() {
        verificationCellDelegate?.handleReviewButtonTapped(for: self)
    }
    
    @objc func handleApproveButton() {
        verificationCellDelegate?.handleApproveButtonTapped(for: self)
    }
    
    //    MARK: - Constraints
    
    func configureCell() {
        
        let buttonStackView = UIStackView(arrangedSubviews: [reviewButton, approveButton])
        buttonStackView.configureStackView(alignment: .fill, distribution: .fillEqually, spacing: 10)
        
        let groupNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel])
        groupNameStackView.configureStackView(alignment: .fill, distribution: .equalSpacing, spacing: 8)
        
        let labelsStackView = UIStackView(arrangedSubviews: [groupNameStackView, toursLabel])
        labelsStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 0)
        labelsStackView.axis = .vertical
        
        addSubview(cellView)
        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 8, paddingRight: 12, width: 0, height: 0)
        
        cellView.addSubview(participantImageView)
        participantImageView.anchor(top: nil, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 96, height: 96)
        participantImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cellView.addSubview(buttonStackView)
        buttonStackView.anchor(top: nil, left: nil, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 240, height: 45)
        buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        cellView.addSubview(labelsStackView)
        labelsStackView.anchor(top: nil, left: participantImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        labelsStackView.centerYAnchor.constraint(equalTo: participantImageView.centerYAnchor).isActive = true
    }
}
