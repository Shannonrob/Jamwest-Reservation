//
//  VerificationVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/13/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SearchUserCell"

class VerificationVC: UIViewController, WaiverVerificationCellDelegate{
    
    //    MARK: - Properties
    
    var verificationView = VerificationView()
    
    // array of custom object
    var waivers = [WaiverVerification]()
    
    //    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificationView.tableView.delegate = self
        verificationView.tableView.dataSource = self
        
        // register cell class
        verificationView.tableView.register(WaiverVerificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        verificationView.tableView.separatorColor = .clear
        verificationView.tableView.allowsSelection = false
        
        view = verificationView
        
        configureUI()
        fetchWaivers()
        rejectedWaiver()
        configureRefreshControl()
    }
    
    
    //    MARK: - Handlers
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleRefresh() {
        waivers.removeAll(keepingCapacity: false)
        fetchWaivers()
        verificationView.tableView.reloadData()
    }
    
    //    MARK: - Helper functions
    
    func configureRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        verificationView.tableView.refreshControl = refreshControl
    }
    
    func configureUI() {
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Waiver Verification"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
    }
    
    //    MARK: -  WaiverVerificationCell Delegate Protocols
    
    func handleReviewButtonTapped(for cell: WaiverVerificationCell) {
        
        guard let waiverDetails = cell.waiver else { return }
        
        let popoverViewController = ReviewVC()
        popoverViewController.waivers = waiverDetails
        popoverViewController.modalPresentationStyle = .custom
        self.present(popoverViewController, animated: true, completion: nil)
    }
    
    func handleApproveButtonTapped(for cell: WaiverVerificationCell) {
        
        print("approve button tapped")
    }
    
    //    MARK: - API
    
    func fetchWaivers() {
        
        PARTICIPANT_WAIVER_REF.observe(.childAdded) { (snapshot) in
            
            //            self.tableView.refreshControl?.endRefreshing()
            
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
            
            self.verificationView.tableView.reloadData()
        }
    }
    
    // removes waiver from tableView
    func rejectedWaiver() {
        
        PARTICIPANT_WAIVER_REF.observe(.childRemoved) { (snapshot) in
            
            self.handleRefresh()
        }
    }
}


extension VerificationVC: UITableViewDataSource, UITableViewDelegate {
    
    //    MARK: - TableView flow layout
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //    MARK: - TableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WaiverVerificationCell
        
        cell.verificationCellDelegate = self
        cell.waiver = waivers[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
}
