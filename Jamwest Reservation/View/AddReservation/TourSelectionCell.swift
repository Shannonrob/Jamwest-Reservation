//
//  TourSelectionCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/27/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class TourSelectionCell: UITableViewCell {
    
    //    MARK: - Properties
    
    let cellView: UIView = {
        
        let view = UIView()
        view.setShadow()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        view.layer.borderWidth = 0.80
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    let tourLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let icon: UIImageView = {
        
        let icon = UIImageView()
        icon.backgroundColor = .lightGray
        return icon
    }()
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureConstraints()
        backgroundColor = .clear
        
        tourLabel.text = "Tour label"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Constraints
    
    func configureConstraints() {
        
        addSubview(cellView)
        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 35, paddingBottom: 4, paddingRight: 35, width: 0, height: 0)
        
        cellView.addSubview(tourLabel)
        tourLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        tourLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        addSubview(icon)
        icon.anchor(top: nil, left: tourLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        icon.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }
}
