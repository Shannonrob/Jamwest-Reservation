//
//  WaiverVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class WaiverVC: UIViewController {
    
//    MARK: - Properties
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
    }
    
//    MARK: - Selectors
    
    @objc func handleDismiss(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
//    MARK:- Helper Functions
    
    func configureUI() {
         view.backgroundColor = .white

        navigationItem.title = "Settings for TJ - Fanguul"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor.init(displayP3Red: 17/255, green: 16/255, blue: 38/255, alpha: 95)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteDismiss ").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
}
