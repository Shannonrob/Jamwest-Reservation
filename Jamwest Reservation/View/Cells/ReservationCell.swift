//
//  ReservationCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ReservationCell: UICollectionViewCell {
    
    var reservation: Reservation? {
        
        didSet {
            
            guard let firstName = reservation?.firstName,
                let lastName = reservation?.lastName,
                let hotel = reservation?.hotel,
                let time = reservation?.time,
                let package = reservation?.package,
                let pendingWaivers = reservation?.pax else { return }
            
            firstNameLabel.text = firstName
            lastNameLabel.text = lastName
            hotelNameLabel.text = hotel
            reservationTimeLabel.text = time
            packageNameLabel.text = package
            pendingWaiversCountLabel.text = "\(pendingWaivers)"
        }
    }
    
    //    MARK: - Labels
    
    let timeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Time"
        label.textColor = .gray
        label.font = UIFont(name: Font.avenirNextMedium, size: 18)
        return label
    }()
    
    let packageLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Package"
        label.textColor = .gray
        label.font = UIFont(name: Font.avenirNextMedium, size: 18)
        return label
    }()
    
    let pendingWaiversLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Waivers"
        label.textColor = .gray
        label.font = UIFont(name: Font.avenirNextMedium, size: 18)
        return label
    }()
    
    let firstNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "First Name"
        label.textColor = Color.Primary.orange
        label.font = UIFont(name: Font.avenirNextDemibold, size: 24)
        return label
    }()
    
    let lastNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Last Name"
        label.textColor = Color.Primary.orange
        label.font = UIFont(name: Font.avenirNextDemibold, size: 24)
        return label
    }()
    
    let hotelNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Name of hotel"
        label.textColor = Color.Primary.heavyGreen
        label.font = UIFont(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    let reservationTimeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Time"
        label.textColor = Color.Primary.heavyGreen
        label.font = UIFont(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    let pendingWaiversCountLabel: UILabel = {
        
        let label = UILabel()
        label.text = "6"
        label.textColor = .orange
        label.font = UIFont(name: Font.avenirNextDemibold, size: 24)
        return label
    }()
    
    let packageNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Package Name"
        label.textColor = Color.Primary.heavyGreen
        label.font = UIFont(name: Font.avenirNextDemibold, size: 22)
        return label
    }()
    
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //    MARK: - Configure Cell Constraints
    
    func configureCell() {
        
        //name stackViews
        let groupNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel])
        groupNameStackView.configureStackView(alignment: .fill, distribution: .equalSpacing, spacing: 8)
        
        // left stackViews
        let headerStackView = UIStackView(arrangedSubviews: [groupNameStackView, hotelNameLabel])
        headerStackView.configureStackView(alignment: .center, distribution: .fillProportionally, spacing: nil)
        headerStackView.axis = .vertical
        
        let timeStackView = UIStackView(arrangedSubviews: [timeLabel, reservationTimeLabel])
        timeStackView.configureStackView(alignment: .center, distribution: .fillEqually, spacing: nil)
        timeStackView.axis = .vertical
        
        let packageStackView = UIStackView(arrangedSubviews: [packageLabel, packageNameLabel])
        packageStackView.configureStackView(alignment: .center, distribution: .fillEqually, spacing: nil)
        packageStackView.axis = .vertical
        
        // center stackView
        let waiverStackView = UIStackView(arrangedSubviews: [pendingWaiversLabel, pendingWaiversCountLabel])
        waiverStackView.configureStackView(alignment: .center, distribution: .fillEqually, spacing: nil)
        waiverStackView.axis = .vertical
        
        //stackView anchors
        addSubview(headerStackView)
        headerStackView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(timeStackView)
        timeStackView.anchor(top: headerStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: (frame.width / 2) - 20, height: 50)
        
        addSubview(waiverStackView)
        waiverStackView.anchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 50)
        waiverStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(packageStackView)
        packageStackView.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: (frame.width / 2) - 30, height: 50)
    }
}
