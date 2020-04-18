//
//  PendingWaiversVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/17/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class PendingWaiversVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.Background.fadeGray
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
        
        let loadingVC = LoadingVC()
        add(loadingVC)
    }
    
    @objc func handleDismiss() {
        
       dismissDetail()
    }
}
