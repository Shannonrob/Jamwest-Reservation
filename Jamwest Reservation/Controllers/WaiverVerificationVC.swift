//
//  PendingWaiversVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/17/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SearchUserCell"

class WaiverVerificationVC: UITableViewController {

//    MARK: - Properties
    
    var waivers = [WaiverVerification]()
    
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register cell class
        tableView.register(WaiverVerificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.separatorColor = .clear
        
        configureUI()
        fetchWaivers()
    }
    
//    MARK: - TableView flow layout
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
//    MARK: - TableView data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WaiverVerificationCell
        
        cell.backgroundColor = .clear
        return cell
    }
    
//    MARK: - Handlers
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: - API
    
    func fetchWaivers() {
        
        PARTICIPANT_WAIVER_REF.observe(.childAdded) { (snapshot) in
            
            let waiverID = snapshot.key
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            let waiver = WaiverVerification(waiverID: waiverID, dictionary: dictionary)
            
            self.waivers.append(waiver)
            
            print("waiver name is \(waiver.name)")
        }
    }
    
//    MARK: - Helper functions
    
    func configureUI() {
    
        view.backgroundColor = .white
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white

        navigationItem.title = "Waiver Verification"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
    }
}
