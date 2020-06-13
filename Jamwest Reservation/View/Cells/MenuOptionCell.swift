//
//  MenuOptionCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {

    //  MARK: - Properties
    
    let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        return icon
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Sample text"
        return label
    }()
    
    //    MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Color.Primary.heavyGreen
        selectionStyle = .none
       
        
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 45).isActive = true
                
        addSubview(menuLabel)
        menuLabel.translatesAutoresizingMaskIntoConstraints = false
        menuLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        menuLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 12).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
