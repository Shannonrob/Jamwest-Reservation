//
//  JamwestCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/23/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JamwestCell: UITableViewCell {

    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle , reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        configureCell()
        
        headerLabel.text = "Header"
        detailLabel.text = "Detail"
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    
//    MARK: - Labels
    
    let headerLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let detailLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let dateLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    
    func configureCell() {
        
        let labelStackView = UIStackView(arrangedSubviews: [headerLabel, detailLabel])
        labelStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 0)
        labelStackView.axis = .vertical
        
        addSubview(cellView)
        cellView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 35, paddingBottom: 4, paddingRight: 35, width: 0, height: 0)
    
        cellView.addSubview(labelStackView)
        labelStackView.anchor(top: cellView.topAnchor, left: cellView.leftAnchor, bottom: cellView.bottomAnchor, right: nil, paddingTop: 6, paddingLeft: 15, paddingBottom: 6, paddingRight: 0, width: 0, height: 0)

        cellView.addSubview(dateLabel)
        dateLabel.anchor(top: nil, left: nil, bottom: nil, right: cellView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
