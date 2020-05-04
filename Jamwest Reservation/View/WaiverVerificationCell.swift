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
    
    let participantImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 96 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //    MARK: - Button
    
    let reviewButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButtonWithIcon(nil, title: "Review", titleColor: .darkText, buttonColor: Color.Background.fadeGray, cornerRadius: 8)
        button.titleLabel?.font = UIFont.init(name: Font.avenirNextDemibold, size: 18)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
        return button
    }()
    
    let acceptButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButtonWithIcon(nil, title: "Approve", titleColor: .white, buttonColor: Color.Primary.orange, cornerRadius: 8)
        button.titleLabel?.font = UIFont.init(name: Font.avenirNextDemibold, size: 18)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
        return button
    }()
    
//    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        
        textLabel?.text = "Participant name"
        detailTextLabel?.text = "Tours"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 140, y: (textLabel?.frame.origin.y)! - 2, width: (frame.width) / 2, height: ((textLabel?.frame.height)!))
        textLabel?.textColor = .black
        textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        detailTextLabel?.frame = CGRect(x: 140, y: (detailTextLabel?.frame.origin.y)!, width: (frame.width) / 2, height: (detailTextLabel?.frame.height)!)
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
//    MARK: - Constraints
    
    func configureCell() {
        
        let buttonStackView = UIStackView(arrangedSubviews: [reviewButton, acceptButton])
        buttonStackView.configureStackView(alignment: .fill, distribution: .fillEqually, spacing: 10)
        
        addSubview(participantImageView)
        participantImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 25, paddingBottom: 0, paddingRight: 0, width: 96, height: 96)
        participantImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 240, height: 45)
        buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
