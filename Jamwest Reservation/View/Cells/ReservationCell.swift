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
            
            guard let name = reservation?.group else { return }
            guard let hotel = reservation?.hotel else { return }
            guard let time = reservation?.time else { return }
            guard let package = reservation?.package else { return }
            guard let pendingWaivers = reservation?.pax else { return }
            
            groupNameLabel.text = name
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
    
    let groupNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Name of group"
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
        
        // left stackViews
        let groupStackView = UIStackView(arrangedSubviews: [groupNameLabel, hotelNameLabel])
        groupStackView.configureStackView(alignment: .center, distribution: .fillProportionally, spacing: nil)
        groupStackView.axis = .vertical
        
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
        addSubview(groupStackView)
        groupStackView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        groupStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(timeStackView)
        timeStackView.anchor(top: groupStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: (frame.width / 2) - 20, height: 50)
        
        addSubview(waiverStackView)
        waiverStackView.anchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 50)
        waiverStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(packageStackView)
        packageStackView.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: (frame.width / 2) - 30, height: 50)
    }
}
