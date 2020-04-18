//
//  LoadingVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/17/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .white
        view.addSubview(spinner)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Center our spinner both horizontally & vertically
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
