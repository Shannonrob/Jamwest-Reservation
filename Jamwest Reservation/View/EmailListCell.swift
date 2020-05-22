//
//  EmailListCell.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/22/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class EmailListCell: UITableViewCell {
    
    var emailList : EmailList? {
        
        didSet {
            
            guard let name = emailList?.group,
                let email = emailList?.emailAddress else { return }
            
            textLabel?.text = name
            detailTextLabel?.text = email
        }
    }
    
    //    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 40, y: (textLabel?.frame.origin.y)! , width: (frame.width) / 2, height: ((textLabel?.frame.height)!))
        textLabel?.textColor = .black
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        detailTextLabel?.frame = CGRect(x: 40, y: (detailTextLabel?.frame.origin.y)!, width: (frame.width) / 2, height: (detailTextLabel?.frame.height)! + 2)
        
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        
    }
}