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
    var approvedWaiversFetchLimit = 100
    var currentApprovedWaiverCount = 100
    var startDataFetchAt = "A"
    
    // instantiate view
    var verificationView = VerificationView()
    
    // array of custom object
    var pendingWaivers = [WaiverVerification]()
    var filteredPendingWaivers = [WaiverVerification]()
    var approvedWaivers = [ApprovedWaiver]()
    var filteredApprovedWaivers = [ApprovedWaiver]()
    var searchedResultWaivers = [ApprovedWaiver]()
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
        checkEmptyState(PARTICIPANT_WAIVER_REF)
        observeWaiversRejected()
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
        if searchedResultWaivers.count > 0 { searchedResultWaivers.removeAll() }
        showSearchBar(shouldShow: false)
        inSearchMode = false
        verificationView.tableView.reloadData()
        verificationView.segmentedContol.isEnabled = true
    }
    
    
    // refresh based current cell
    @objc func handleRefresh() {
        dismissEmptyStateView()
        switch isShowingPendingWaivers {
            
        case true:
            pendingWaivers.removeAll(keepingCapacity: false)
            checkEmptyState(PARTICIPANT_WAIVER_REF)
            fetchPendingWaiver()
            
        default:
            approvedWaivers.removeAll(keepingCapacity: false)
            fetchApprovedWaiver(quantity: approvedWaiversFetchLimit, startAt: startDataFetchAt)
            checkEmptyState(APPROVED_WAIVER_REF)
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
    
    
    func updateTableView(for cell: WaiverVerificationCell) {
        
        if let indexPath = self.verificationView.tableView.indexPath(for: cell){
            let row: IndexPath = [indexPath.section, indexPath.row]
            self.pendingWaivers.remove(at: indexPath.row)
            self.verificationView.tableView.deleteRows(at: [row], with: .automatic)
            Alert.showAlert(on: self, with: "Approved Successfully 👍")
        }
    }
    
    
    func configureUI() {
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation ,NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.title = "Waiver Verification"
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
            heightForRow = 60
            switchIdentifier(with: false)
            isShowingPendingWaivers = false
        }
        self.verificationView.tableView.reloadData()
    }
    
    
    func handleFetchedWaiversResult(for waiver: WaiverVerification) {
        let waiverID = waiver.waiverID
        
        if let existingIndex = self.pendingWaivers.firstIndex(where: { $0.waiverID == waiverID }) {
            self.pendingWaivers[existingIndex] = waiver
        } else {
            self.pendingWaivers.append(waiver)
        }
        
        pendingWaivers.sort { (waiver1, waiver2) -> Bool in
            return waiver1.fullNameReversed.lowercased() < waiver2.fullNameReversed.lowercased()
        }
        verificationView.tableView.reloadData()
    }
    
    
    func handleApprovedWaiversResult(for waiver: ApprovedWaiver) {
        
        let waiverID = waiver.waiverID
        
        if let existingIndex = self.approvedWaivers.firstIndex(where: { $0.waiverID == waiverID }) {
            self.approvedWaivers[existingIndex] = waiver
        } else {
            self.approvedWaivers.append(waiver)
        }
        
        approvedWaivers.sort { (waiver1, waiver2) -> Bool in
            return waiver1.fullNameReversed.lowercased() < waiver2.fullNameReversed.lowercased()
        }
        verificationView.tableView.reloadData()
    }
    
    
    func handleSearchResult(for name: String, in waiver: ApprovedWaiver) {
        searchedResultWaivers.append(waiver)
        
        filteredApprovedWaivers = searchedResultWaivers.filter({ (waiver) -> Bool in
            return waiver.fullName.localizedCaseInsensitiveContains(name)
        })
        
        filteredApprovedWaivers.sort { (waiver1, waiver2) -> Bool in
            return waiver1.fullNameReversed.lowercased() < waiver2.fullNameReversed.lowercased()
        }
        self.verificationView.tableView.reloadData()
    }
    
    
    func handleEmptyStateResult() {
        dismissLoadingView()
        let emptyStateMessage = Label.noPendingWaiver
        
        DispatchQueue.main.async {
            self.showEmptyStateView(with: emptyStateMessage, in: self.verificationView.tableView)
            self.verificationView.tableView.refreshControl?.endRefreshing()
            return
        }
    }
    
    
    func grabNextLetterToFetch() -> String{
        currentApprovedWaiverCount += 100
        
        let startPoint = approvedWaivers.last
        var result: String!
        
        if let letters = startPoint?.fullNameReversed {
            result = String(letters.prefix(12))
        }
        return result
    }
    
    
    func removeAtIndex(for waiver: DataSnapshot){
        let waiverID = waiver.key
        guard isShowingPendingWaivers else { return }
        
        if let existingIndex = self.pendingWaivers.firstIndex(where: { $0.waiverID == waiverID }) {
            let row: IndexPath = [0, existingIndex]
            self.pendingWaivers.remove(at: existingIndex)
            self.verificationView.tableView.deleteRows(at: [row], with: .fade)
        }
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
        popoverViewController.verificationVC = self
        popoverViewController.waivers = waiverDetails
        popoverViewController.cell = cell
        popoverViewController.modalPresentationStyle = .custom
        self.present(popoverViewController, animated: true, completion: nil)
    }
    
    
    func handleApproveButtonTapped(for cell: WaiverVerificationCell) {
        approveWaiver(for: cell)
    }
    
    
    // handle segmentedControl
    func handleSegmentedControl(for vc: VerificationView) {
        let control = verificationView.segmentedContol
        
        switch control.selectedSegmentIndex {
            
        case 0 :
            waiverToDisplay(on: .PendingWaivers)
            APPROVED_WAIVER_REF.removeAllObservers()
        case 1 :
            waiverToDisplay(on: .ApprovedWaivers)
            currentApprovedWaiverCount = 100
            PARTICIPANT_WAIVER_REF.removeAllObservers()
        default:
            break
        }
        handleRefresh()
    }
    
    
    //    MARK: - API
    
    func fetchPendingWaiver() {
        showLoadingView()
        NetworkManager.shared.fetchPendingWaivers { [weak self] result in
            
            guard let self = self else { return }
            self.checkEmptyState(PARTICIPANT_WAIVER_REF)
            
            switch result {
            case .success(let waiver):
                self.handleFetchedWaiversResult(for: waiver)
            case .failure(let error):
                DispatchQueue.main.async { Alert.showAlert(on: self, with: error.rawValue)}
            }
        }
    }
    
    
    func fetchApprovedWaiver(quantity value:Int, startAt: String) {
        showLoadingView()
        
        NetworkManager.shared.fetchApprovedWaivers(quantity: value, startAt: startAt) { [weak self] result in
            
            guard let self = self else { return }
            self.checkEmptyState(APPROVED_WAIVER_REF)
            
            switch result {
            case .success(let waiver):
                self.handleApprovedWaiversResult(for: waiver)
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func observeWaiversRejected() {
        NetworkManager.shared.observeChildRemoved(for: PARTICIPANT_WAIVER_REF) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let waiver):
                guard let waiver = waiver else { return }
                self.removeAtIndex(for: waiver)
            case .failure(_):
                break
            }
        }
    }
    
    func searchApprovedWaivers(for name: String) {
        showLoadingView()
        NetworkManager.shared.searchApprovedWaivers() { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result{
            case .success(let waiver):
                self.handleSearchResult(for: name, in: waiver)
            case .failure(_):
                break
            }
        }
    }
    
    
    func approveWaiver(for cell: WaiverVerificationCell) {
        
        guard let creationDate = Date.CurrentDate(),
            let waiverId = cell.waiver?.waiverID,
            let firstName = cell.waiver?.firstName,
            let lastName = cell.waiver?.lastName,
            let fullName = cell.waiver?.fullName,
            let fullNameReversed = cell.waiver?.fullNameReversed else { return }
        
        guard let imageURL = cell.waiver?.imageURL else {
            Alert.showRequiredMessage(on: self, with: ErrorMessage.photoRequired)
            return
        }
        
        var values = [String:Any]()
        values[Constant.firstName] = firstName
        values[Constant.lastName] = lastName
        values[Constant.fullName] = fullName
        values[Constant.fullNameReversed] = fullNameReversed
        values[Constant.imageURL] = imageURL
        values[Constant.creationDate] = creationDate
        
        showLoadingView()
        NetworkManager.shared.approveWaiver(for: waiverId, with: values) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let waiverID):
                self.updateTableView(for: cell)
                
                
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                    self.deletePendingWaiver(withImage: true, withImage: imageURL, waiverID: waiverID)
                }
                
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func deletePendingWaiver(withImage condition: Bool, withImage imageURL: String?, waiverID: String) {
        NetworkManager.shared.deletePendingWaiver(withImage: condition, imageURL: imageURL, forWaiver: waiverID)
    }
    
    
    func checkEmptyState(_ reference: DatabaseReference) {
        NetworkManager.shared.checkDataBaseEmptyState(for: reference) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingView()
            }
            
            switch result {
            case .success(let snapshot):
                
                if !snapshot.exists() {
                    self.handleEmptyStateResult()
                    return
                } else {
                    self.dismissLoadingView()
                    self.dismissEmptyStateView()
                    self.verificationView.tableView.refreshControl?.endRefreshing()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {Alert.showAlert(on: self, with: error.rawValue)}
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
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        switch isShowingPendingWaivers {
            
        case true:
            break
        case false:
            
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            var approvedWaiverCount: Int!
            
            if offsetY > contentHeight - height {
                
                for waiver in 0...approvedWaivers.count { approvedWaiverCount = waiver }
                if currentApprovedWaiverCount > approvedWaiverCount { return }
                
                let startPoint = grabNextLetterToFetch()
                fetchApprovedWaiver(quantity: approvedWaiversFetchLimit + 1, startAt: startPoint)
            }
        }
    }
}


extension VerificationVC: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchedResultWaivers.removeAll()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        if !isShowingPendingWaivers { searchApprovedWaivers(for: text.lowercased()) }
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
                    return reservation.fullName.localizedCaseInsensitiveContains(searchText)
                })
            } else {
                
                filteredApprovedWaivers = approvedWaivers.filter({ (reservation) -> Bool in
                    return reservation.fullName.localizedCaseInsensitiveContains(searchText)
                })
            }
            self.verificationView.tableView.reloadData()
        }
    }
}

