//
//  VerificationView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/13/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class VerificationView: UIView {
    
    var verificationDelegate: VerificationDelegate?
    
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
    
    let segmentControlView: UIView = {
        let segView = UIView()
        segView.backgroundColor = Color.Primary.heavyGreen
        return segView
    }()
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        return tableView
    }()
    
    let segmentedContol: UISegmentedControl = {

        let control = UISegmentedControl(items: ["Pending", "Approved"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .white
        control.backgroundColor = .systemBackground
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.Primary.heavyGreen, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)], for: .selected)
        control.addTarget(self, action: #selector(handleSegmentedControl), for: .valueChanged)
        return control
    }()
    
//    MARK: - Handlers
    
    @objc func handleSegmentedControl() {
        verificationDelegate?.handleSegmentedControl(for: self)
    }
    
    //    MARK: - Contraints
    
    func configureConstraints() {
        
        addSubview(segmentControlView)
        segmentControlView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 48)
        
        segmentControlView.addSubview(segmentedContol)
        segmentedContol.anchor(top: segmentControlView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 260, height: 40)
        segmentedContol.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(tableView)
        tableView.anchor(top: segmentControlView.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
