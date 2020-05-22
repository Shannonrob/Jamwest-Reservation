//
//  EditReservationCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/19/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class EditReservationCell: UITableViewCell {

    var reservation : EditReservation? {
        
        didSet {
            
            guard let name = reservation?.group,
                  let hotel = reservation?.hotel else { return }
            
            textLabel?.text = name
            detailTextLabel?.text = hotel
        }
    }
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        // separator insets
        separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 40, y: (textLabel?.frame.origin.y)! , width: (frame.width) / 2, height: ((textLabel?.frame.height)!))
        textLabel?.textColor = .black
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        detailTextLabel?.frame = CGRect(x: 40, y: (detailTextLabel?.frame.origin.y)!, width: (frame.width) / 2, height: (detailTextLabel?.frame.height)!)
        
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 16)

    }
}
