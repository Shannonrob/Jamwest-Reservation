//
//  TourSelectionView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/27/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class TourSelectionView: UIView {

    var delegate: TourSelectionDelegate?
    
    //    MARK: - Properties
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        return tableView
    }()
    
    let submitButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.backgroundColor = Color.Hue.green
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(handleSubmitTapped), for: .touchUpInside)
        return button
    }()
    
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Color.Background.fadeGray
        tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        configureContraints()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - Handlers
    
    @objc func handleSubmitTapped() {
        delegate?.handleSubmitButton(for: self)
    }
    
//    MARK: - Constraint
    
    func configureContraints() {
     
        addSubview(tableView)
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(submitButton)
        submitButton.anchor(top: tableView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 50, paddingRight: 15, width: 0, height: 60)
    }
}
