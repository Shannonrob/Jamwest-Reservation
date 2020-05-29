//
//  TourSelectionCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/27/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class TourSelectionCell: UITableViewCell {
    
    var tourSelection: TourSelection! {
        
        didSet {
            guard let title = tourSelection.title else { return }
            guard let image = tourSelection.image else { return }
            
            tourLabel.text = title
            icon.image = image
        }
    }
    
    //    MARK: - Properties
    let icon = UIImageView()
    let backgrounView = UIView()
 
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
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        configureConstraints()
        backgroundColor = .clear
        
        backgrounView.backgroundColor = Color.Primary.orange
        selectedBackgroundView = backgrounView
        
        tourLabel.text = "Tour label"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Constraints
    
    func configureConstraints() {
        
        addSubview(cellView)
        cellView.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 35, paddingBottom: 0, paddingRight: 35, width: 0, height: 44)
        cellView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        cellView.addSubview(tourLabel)
        tourLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        tourLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        addSubview(icon)
        icon.anchor(top: nil, left: tourLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        icon.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
    }
}
