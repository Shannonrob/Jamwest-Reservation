//
//  VerificationView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/13/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class VerificationView: UIView {
    
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Properties
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let segmentedContol: UISegmentedControl = {
        
        let control = UISegmentedControl(items: ["Pending", "Verified"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = Color.Primary.heavyGreen
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        return control
    }()
    
    //    MARK: - Contraints
    
    func configureConstraints() {
        
        addSubview(segmentedContol)
        segmentedContol.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 260, height: 40)
        segmentedContol.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(tableView)
        tableView.anchor(top: segmentedContol.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
}
