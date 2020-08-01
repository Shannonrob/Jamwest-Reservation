//
//  JWTableViewCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 7/20/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JWTableViewCell: UITableViewCell {
    
    //    MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureCell()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - View
    
    let cellView: UIView = {
        
        let view = UIView()
        view.addShadow()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        view.layer.borderWidth = 0.80
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    
    //    MARK: - Labels
    
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
    
    let detailLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Details"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    func configureCell() {
        
        let groupNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel])
        groupNameStackView.configureStackView(alignment: .fill, distribution: .equalSpacing, spacing: 5)
        
        addSubview(cellView)
        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 35, paddingBottom: 4, paddingRight: 35, width: 0, height: 0)
        
        cellView.addSubview(groupNameStackView)
        groupNameStackView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        groupNameStackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        cellView.addSubview(detailLabel)
        detailLabel.anchor(top: nil, left: nil, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
