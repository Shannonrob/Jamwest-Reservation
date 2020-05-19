//
//  ApprovedWaiverCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/14/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ApprovedWaiverCell: UITableViewCell {
    
    var approvedWaiver: ApprovedWaiver? {
        
        didSet {
            
            guard let name = approvedWaiver?.name else { return }
//            guard let imageURL = approvedWaiver?.imageURL else { return }
            guard let date = approvedWaiver?.creationDate else { return}
            
            textLabel?.text = name
            detailTextLabel?.text = date
        }
    }
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        textLabel?.text = "Shannon Robinson"
        detailTextLabel?.text = "May 13, 2020"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 40, y: (textLabel?.frame.origin.y)! - 2, width: (frame.width) / 2, height: ((textLabel?.frame.height)!))
        textLabel?.textColor = .black
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        detailTextLabel?.frame = CGRect(x: 40, y: (detailTextLabel?.frame.origin.y)!, width: (frame.width) / 2, height: (detailTextLabel?.frame.height)! + 5)
        
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
    }
}
