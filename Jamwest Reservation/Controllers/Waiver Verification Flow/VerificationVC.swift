//
//  VerificationVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/13/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "WaiverVerificationCell"
private let approvedReuseIdentifier = "ApprovedWaiverCell"

class VerificationVC: UIViewController, WaiverVerificationCellDelegate, VerificationDelegate {
    
    //    MARK: - Properties
    var heightForRow = 150
    var isShowingPendingWaivers = true
    
    // instantiate view
    var verificationView = VerificationView()
    
    // array of custom object
    var pendingWaivers = [WaiverVerification]()
    var approvedWaivers = [ApprovedWaiver]()
    
    //    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = verificationView
        verificationView.verificationDelegate = self
        verificationView.tableView.delegate = self
        verificationView.tableView.dataSource = self
        
        switchIdentifier(with: true)
        
        configureUI()
        fetchPendingWaiver()
        fetchApprovedWaiver()
        rejectedWaiver()
        configureRefreshControl()
    }
    
    //    MARK: - Handlers
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // refresh based current cell
    @objc func handleRefresh() {
        
        switch isShowingPendingWaivers {
            
        case true:
            pendingWaivers.removeAll(keepingCapacity: false)
            fetchPendingWaiver()
            
        default:
            approvedWaivers.removeAll(keepingCapacity: false)
            fetchApprovedWaiver()
        }
        verificationView.tableView.reloadData()
    }
    
    //    MARK: - Helper functions
    
    func configureRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteBack ").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
    // operations for the enum
    func waiverToDisplay(on tableView: Waivers) {
        
        switch tableView {
            
        case .PendingWaivers:
            
            heightForRow = 150
            switchIdentifier(with: true)
            isShowingPendingWaivers = true
            
        case .ApprovedWaivers:
            
            heightForRow = 70
            switchIdentifier(with: false)
            isShowingPendingWaivers = false
        }
        self.verificationView.tableView.reloadData()
    }
    
    // register appropriate cell based on condition
    func switchIdentifier(with condition: Bool) {
        
        if condition {
            verificationView.tableView.register(WaiverVerificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        } else {
            verificationView.tableView.register(ApprovedWaiverCell.self, forCellReuseIdentifier: approvedReuseIdentifier)
        }
    }
    
    //    MARK: - Delegate Protocols
    
    // handle reviewButton
    func handleReviewButtonTapped(for cell: WaiverVerificationCell) {
        
        guard let waiverDetails = cell.waiver else { return }
        
        let popoverViewController = ReviewVC()
        popoverViewController.waivers = waiverDetails
        popoverViewController.modalPresentationStyle = .custom
        self.present(popoverViewController, animated: true, completion: nil)
    }
    
    // handle approvedButton
    func handleApproveButtonTapped(for cell: WaiverVerificationCell) {
        
        print("approve button tapped")
    }
    
    // handle segmentedControl
    func handleSegmentedControl(for vc: VerificationView) {
        
        let control = verificationView.segmentedContol
        
        switch control.selectedSegmentIndex {
            
        case 0 :
            waiverToDisplay(on: .PendingWaivers)
        case 1 :
            waiverToDisplay(on: .ApprovedWaivers)
        default:
            break
        }
    }
    
    //    MARK: - API
    
    // fetch pending waivers
    func fetchPendingWaiver() {
        
        PARTICIPANT_WAIVER_REF.observe(.childAdded) { (snapshot) in
            
            self.verificationView.tableView.refreshControl?.endRefreshing()
            
            // waiverID
            let waiverID = snapshot.key
            
            // snapshot value cast as dictionary
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            
            // construct waiver
            let waiver = WaiverVerification(waiverID: waiverID, dictionary: dictionary)
            
            // append waiver to data source
            self.pendingWaivers.append(waiver)
            
            // sort results in alphabetical order
            self.pendingWaivers.sort { (waiver1, waiver2) -> Bool in
                return waiver1.name < waiver2.name
            }
            
            self.verificationView.tableView.reloadData()
        }
    }
    
    // fetch approved waivers
    func fetchApprovedWaiver() {
        
        Database.fetchWaiver(from: APPROVED_WAIVER_REF) { (waiver) in
            
            self.verificationView.tableView.refreshControl?.endRefreshing()
            
            // append waiver to data source
            self.approvedWaivers.append(waiver)
            
            // sort results in alphabetical order
            self.approvedWaivers.sort { (waiver1, waiver2) -> Bool in
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
        return CGFloat(heightForRow)
    }
    
    //    MARK: - TableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isShowingPendingWaivers {
            return pendingWaivers.count
        } else {
            return approvedWaivers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch isShowingPendingWaivers {
            
        case true:
            
            tableView.allowsSelection = false
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WaiverVerificationCell
            cell.verificationCellDelegate = self
            cell.waiver = pendingWaivers[indexPath.row]
            return cell
            
        default:
            
            tableView.allowsSelection = true
            
            let cell = tableView.dequeueReusableCell(withIdentifier: approvedReuseIdentifier, for: indexPath) as! ApprovedWaiverCell
            cell.approvedWaiver = approvedWaivers[indexPath.row]
            return cell
        }
    }
}
