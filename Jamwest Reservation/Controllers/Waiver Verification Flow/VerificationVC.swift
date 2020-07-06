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
    var inSearchMode = false
    
    // instantiate view
    var verificationView = VerificationView()
    
    // array of custom object
    var pendingWaivers = [WaiverVerification]()
    var filteredPendingWaivers = [WaiverVerification]()
    var approvedWaivers = [ApprovedWaiver]()
    var filteredApprovedWaivers = [ApprovedWaiver]()
    let searchBar = JWSearchBar.init(placeHolder: "Search Waiver")
    
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
    
    @objc func handleSearch() {
        
        showSearchBar(shouldShow: true)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        verificationView.segmentedContol.isEnabled = false
    }
    
    @objc func handleCancelSearch() {
        
        showSearchBar(shouldShow: false)
        inSearchMode = false
        verificationView.tableView.reloadData()
        verificationView.segmentedContol.isEnabled = true
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
    
    // switches between searchBar to cancel button
    func showSearchBarButton(shouldShow: Bool) {
        
        if shouldShow {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch))]
        } else {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelSearch))]
        }
    }
    
    func showSearchBar(shouldShow: Bool) {
        // shows searchbar if true
        showSearchBarButton(shouldShow: !shouldShow)
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
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
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation ,NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteBack ").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
        showSearchBarButton(shouldShow: true)
        
        verificationView.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
    
    // presents cameraVC
    func showCameraVC(for waiver: Dictionary<String, Any>) {
        
        presentCameraVC(for: .UpdateProfileImage, with: waiver)
    }
    
    //    MARK: - Delegate Protocols
    
    // handle reviewButton
    func handleReviewButtonTapped(for cell: WaiverVerificationCell) {
        
        guard let waiverDetails = cell.waiver else { return }
        
        let popoverViewController = ReviewVC()
        popoverViewController.verificationVC = self
        popoverViewController.waivers = waiverDetails
        popoverViewController.modalPresentationStyle = .custom
        self.present(popoverViewController, animated: true, completion: nil)
    }
    
    // handle approvedButton
    func handleApproveButtonTapped(for cell: WaiverVerificationCell) {
        
        approvedWaiver(for: cell)
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
        handleRefresh()
    }
    
    //    MARK: - API
    
    // fetch pending waivers
    func fetchPendingWaiver() {
        showLoadingView()
        
        Database.fetchPendingWaivers(from: PARTICIPANT_WAIVER_REF) { [weak self] (waiver) in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            self.verificationView.tableView.refreshControl?.endRefreshing()
            
            let waiverID = waiver.waiverID
            
            if let existingIndex = self.pendingWaivers.firstIndex(where: { $0.waiverID == waiverID }) {
                
                self.pendingWaivers[existingIndex] = waiver
            } else {
                self.pendingWaivers.append(waiver)
            }
            
            // sort results in alphabetical order
            self.pendingWaivers.sort { (waiver1, waiver2) -> Bool in
                return waiver1.name < waiver2.name
            }
            self.verificationView.tableView.reloadData()
        }
    }
    
    // fetch approved waivers
    func fetchApprovedWaiver() {
        
        Database.fetchWaiver(from: APPROVED_WAIVER_REF) { [weak self] (waiver) in
            guard let self = self else { return }
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
        
        PARTICIPANT_WAIVER_REF.observe(.childRemoved) { [weak self] (snapshot) in
            guard let self = self else { return }
            self.handleRefresh()
        }
    }
    
    func approvedWaiver(for cell: WaiverVerificationCell) {
        
        showLoadingView()
        guard let creationDate = Date.CurrentDate() else { return }
        guard let waiverId = cell.waiver?.waiverID else { return }
        guard let name = cell.waiver?.name else { return }
        guard let image = cell.waiver?.imageURL else {
            
            Alert.showRequiredMessage(on: self, with: "Participant photo is required!")
            return
        }
        
        var values = [String:Any]()
        values[Constant.name] = name
        values[Constant.imageURL] = image
        values[Constant.creationDate] = creationDate
        
        // get waiverID and upload approved waiver
        let approvedWaiverID = APPROVED_WAIVER_REF.child(waiverId)
        
        approvedWaiverID.updateChildValues(values) { [weak self] (error, ref) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            if let error = error {
                
                Alert.showErrorMessage(on: self , with: "Error \(error.localizedDescription)")
            } else {
                
                // delete waiver from pending
                cell.waiver?.removeWaiver(id: waiverId, withImage: true)
            }
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
            
            // pending waivers
            if inSearchMode {
                return filteredPendingWaivers.count
            } else {
                return pendingWaivers.count
            }
        } else {
            
            // approved waivers
            if inSearchMode {
                return filteredApprovedWaivers.count
            } else {
                return approvedWaivers.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch isShowingPendingWaivers {
            
        case true:
            
            tableView.allowsSelection = false
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WaiverVerificationCell
            cell.verificationCellDelegate = self
            
            // Configure in search mode
            var waiver: WaiverVerification!
            
            if inSearchMode {
                waiver = filteredPendingWaivers[indexPath.row]
            } else {
                waiver = pendingWaivers[indexPath.row]
            }
            cell.waiver = waiver
            return cell
            
        case false:
            
            tableView.allowsSelection = true
            
            let cell = tableView.dequeueReusableCell(withIdentifier: approvedReuseIdentifier, for: indexPath) as! ApprovedWaiverCell
            
            var waiver: ApprovedWaiver!
            
            if inSearchMode {
                waiver = filteredApprovedWaivers[indexPath.row]
            } else {
                waiver = approvedWaivers[indexPath.row]
            }
            cell.approvedWaiver = waiver
            return cell
        }
    }
}

extension VerificationVC: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // filters search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText
        
        if searchText.isEmpty || searchText == " " {
            inSearchMode = false
            self.verificationView.tableView.reloadData()
        } else {
            
            inSearchMode = true
            
            if isShowingPendingWaivers {
                
                filteredPendingWaivers = pendingWaivers.filter({ (reservation) -> Bool in
                    return reservation.name.localizedCaseInsensitiveContains(searchText)
                })
            } else {
                
                filteredApprovedWaivers = approvedWaivers.filter({ (reservation) -> Bool in
                    return reservation.name.localizedCaseInsensitiveContains(searchText)
                })
            }
            self.verificationView.tableView.reloadData()
        }
    }
}
