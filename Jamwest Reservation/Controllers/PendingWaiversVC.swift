//
//  PendingWaiversVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/17/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class PendingWaiversVC: UITableViewController {

    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
//    MARK: - TableView data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
//    MARK: - Handlers
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: - Helper functions
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white

        navigationItem.title = ""
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
    }
}
