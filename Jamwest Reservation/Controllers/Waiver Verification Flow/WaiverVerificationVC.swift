//
//  PendingWaiversVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/17/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SearchUserCell"

class WaiverVerificationVC: UITableViewController, WaiverVerificationCellDelegate{
    
//    MARK: - Properties
    
    // array of custom object
    var waivers = [WaiverVerification]()
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register cell class
        tableView.register(WaiverVerificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        
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
        return waivers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WaiverVerificationCell
        
        cell.verificationCellDelegate = self
        cell.waiver = waivers[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
//    MARK: - Handlers
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: -  WaiverVerificationCell Delegate Protocols
    
    func handleReviewButtonTapped(for cell: WaiverVerificationCell) {
        
        guard let waiverDetails = cell.waiver else { return }
        
        let popoverViewController = ReviewVC()

        popoverViewController.waivers = waiverDetails
        popoverViewController.modalPresentationStyle = .custom
        self.present(popoverViewController, animated: true, completion: nil)
        
//        presentReviewVC()
        
        
    }
    
    func handleApproveButtonTapped(for cell: WaiverVerificationCell) {
        
        print("approve button tapped")
    }
    
//    MARK: - API
    
    func fetchWaivers() {
        
        PARTICIPANT_WAIVER_REF.observe(.childAdded) { (snapshot) in
            
            // waiverID
            let waiverID = snapshot.key
            
            // snapshot value cast as dictionary
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            // construct waiver
            let waiver = WaiverVerification(waiverID: waiverID, dictionary: dictionary)
            
            // append waiver to data source
            self.waivers.append(waiver)
            
            // sort results in alphabetical order
            self.waivers.sort { (waiver1, waiver2) -> Bool in
                return waiver1.name < waiver2.name
            }
            
            self.tableView.reloadData()        }
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
