//
//  EditReservationVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/19/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "EditReservationCell"
private let emailReuseIdentifier = "EmailListCell"

class EditReservationVC: UITableViewController {
    
    //    MARK: - Properties
    var showInformation: ShowInformation!
    var editReservations = [EditReservation]()
    var filteredReservations = [EditReservation]()
    var searchedReservationResult = [EditReservation]()
    var emailsList = [EmailList]()
    var shareEmails = [EmailList]()
    
    var isCellSelected = false
    var inSearchMode = false
    var isShowingReservations = true
    var reservationFetchLimit = 100
    var currentReservationsCount = 100
    var dataFetchStartPoint = "A"
    
    var emptyStateMessage : String!
    var heightForRow: CGFloat!
    var deleteList = [IndexPath]()
    let searchBar = JWSearchBar.init(placeHolder: "Search Group")
    
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register cell class
        tableView.register(EditReservationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.register(EmailListCell.self, forCellReuseIdentifier: emailReuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        
        configureUI()
        configureRefreshControl()
        
        // fetch data based on enum case
        showLoadingView()
        showInformation == .EditReservation ? fetchReservation(limit: reservationFetchLimit, startAt: dataFetchStartPoint) : fetchEmailList()
        showInformation == .EditReservation ? observeChildRemoved(RESERVATION_REF) : observeChildRemoved(PARTICIPANT_EMAIL_REF)
        showInformation == .EditReservation ? checkEmptyState(RESERVATION_REF) : checkEmptyState(PARTICIPANT_EMAIL_REF)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showInformation == .EmailList {
            navigationItem.title = "Email List"
            heightForRow = 60
            emptyStateMessage = Label.noSubscribers
        } else {
            navigationItem.title = "Edit Reservation"
            showSearchBarButton(shouldShow: true)
            heightForRow = 70
            emptyStateMessage = Label.noReservation
        }
    }
    
    
    //     MARK: - TableView flow layout
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch showInformation {
            
        case .EmailList:
            return emailsList.count
        default:
            if inSearchMode {
                return filteredReservations.count
            } else {
                return editReservations.count
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // present cell based on case
        switch showInformation {
            
        case .EmailList:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: emailReuseIdentifier, for: indexPath) as! EmailListCell
            
            // Configure the cell...
            cell.emailList = emailsList[indexPath.row]
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditReservationCell
            
            // Configure reservation cell...
            var reservation: EditReservation!
            
            if inSearchMode {
                reservation = filteredReservations[indexPath.row]
            } else {
                reservation = editReservations[indexPath.row]
            }
            
            cell.reservation = reservation
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if showInformation == .EmailList {
            
            let selectedCell: EmailListCell = tableView.cellForRow(at: indexPath) as! EmailListCell
            configureSelectedCell(for: selectedCell, with: Color.Primary.markerColor)
            filterSelectedTours(with: emailsList, for: indexPath)
            filterDeleteArray(for: indexPath)
            configureBarButtonItems()
            return
        }
        
        var reservation: Reservation!
        
        if inSearchMode {
            reservation = filteredReservations[indexPath.row]
        } else {
            reservation = editReservations[indexPath.row]
        }
        presentAddReservationVC(index: 1, with: reservation)
        handleCancelSearch()
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        if showInformation == .EditReservation{
            let reservation = editReservations[indexPath.row].reservationId
            guard let reservationID = reservation else { return }
            
            editReservations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            deleteReservation(with: reservationID, caseType: .EditReservation)
            
        } else {
            let email = emailsList[indexPath.row].waiverID
            guard let emailID = email else { return }
            
            emailsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            deleteReservation(with: emailID, caseType: .EmailList)
        }
    }
    
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if showInformation == .EditReservation {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height
            
            var reservationsCount: Int!
            
            if offsetY > contentHeight - height {
                
                for reservation in 0...editReservations.count { reservationsCount = reservation }
                if currentReservationsCount > reservationsCount { return }
                
                let startPoint = grabNextLetterToFetch()
                fetchReservation(limit: reservationFetchLimit + 1, startAt: startPoint)
            }
        }
    }
    
    
    //    MARK: - Handlers

    @objc func deselectAllCells() {
        for item in deleteList {

            let selectedCell: EmailListCell = tableView.cellForRow(at: item) as! EmailListCell
            configureSelectedCell(for: selectedCell, with: Color.Primary.markerColor)
        }
            
        shareEmails.removeAll()
        deleteList.removeAll()
        isCellSelected = false
        configureBarButtonItems()
    }
    
    
    @objc func handleSearch() {
        
        showSearchBar(shouldShow: true)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    
    @objc func handleCancelSearch() {
        searchedReservationResult.removeAll()
        showSearchBar(shouldShow: false)
        inSearchMode = false
        tableView.reloadData()
    }
    
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // refresh based current cell
    @objc func handleRefresh() {
        
        switch isShowingReservations {
            
        case true:
            editReservations.removeAll(keepingCapacity: false)
            fetchReservation(limit: reservationFetchLimit, startAt: dataFetchStartPoint)
            
        default:
            emailsList.removeAll(keepingCapacity: false)
            fetchEmailList()
        }
        tableView.reloadData()
    }
    
    
    // append and share emails
    @objc func shareList() {
        
        if shareEmails.isEmpty {
            Alert.showAlert(on: self, with: "Select email to share.")
        } else {
            
            var item = String()
            var emails = [String]()
            
            for email in shareEmails {
                emails.append(email.emailAddress ?? "Error")
                item = emails.joined(separator: "\n")
            }
            
            let vc = UIActivityViewController(activityItems: [item], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![2]
            present(vc, animated: true)
        }
    }
    
    
    // handles deletion of emails
    @objc func handleDelete() {
        
        var message: String!
        
        if shareEmails.count >= 2 {
            message = "These emails will be deleted"
        } else {
            message = "This email will be deleted"
        }
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (alert: UIAlertAction!) -> Void in
            guard let self = self else { return }
            
            for item in self.deleteList { self.emailsList.remove(at: item.row) }
            
            for content in self.shareEmails {
                let waiverID = content.waiverID
                guard let email = waiverID else { return }
                self.deleteReservation(with: email, caseType: .EmailList)
            }
            
            self.tableView.deleteRows(at: self.deleteList, with: .automatic)
            self.deleteList.removeAll()
            self.shareEmails.removeAll()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
        })
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //    MARK: - Helper functions
    
    func configureBarButtonItems() {
        
        if shareEmails.count >= 1 && deleteList.count >= 1 {
            isCellSelected = true
        } else if shareEmails.count < 1 {
            isCellSelected = false
        }
        
        guard !isCellSelected else {
             navigationItem.leftBarButtonItem = nil
             navigationItem.leftBarButtonItems = [
             UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
             UIBarButtonItem(image: Image.shareIcon?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(shareList)),
             UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
             UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
             UIBarButtonItem(image: Image.trashIcon?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleDelete))]
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(deselectAllCells))
            return
         }
        
        guard isCellSelected else {
            navigationItem.leftBarButtonItems = nil
            navigationItem.rightBarButtonItem = nil
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteBack "), style: .plain, target: self, action: #selector(handleDismiss))
            return
        }
    }
    
  
    func configureRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    
    // highlight selected cell with custom color
    func configureSelectedCell(for cell: EmailListCell, with color: UIColor) {
        
        if cell.cellView.backgroundColor == color {
            cell.cellView.backgroundColor = .white
            cell.firstNameLabel.textColor = .black
            cell.lastNameLabel.textColor = .black
            cell.detailLabel.textColor = .darkGray
        } else {
            cell.cellView.backgroundColor = color
            cell.firstNameLabel.textColor = .white
            cell.lastNameLabel.textColor = .white
            cell.detailLabel.textColor = .white
        }
    }
    
    
    func configureUI() {
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Edit Reservation"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation ,NSAttributedString.Key.foregroundColor: UIColor.white]
      
        configureBarButtonItems()
    }
    
    
    // filter selected emails to prevent duplicate and append to array
    func filterSelectedTours(with array: [EmailList], for indexPath: IndexPath) {
        let email = array[indexPath.row].emailAddress
        
        if shareEmails.firstIndex(where: { $0.emailAddress == email }) != nil {
            shareEmails.removeAll{ $0.emailAddress == email }
        } else {
            shareEmails.append(emailsList[indexPath.row])
        }
    }
    
    
    func filterDeleteArray(for indexPath: IndexPath) {
        let cell = indexPath
        
        if deleteList.firstIndex(where: { $0 == cell }) != nil {
            deleteList.removeAll{ $0 == cell }
        } else {
            deleteList.append(cell)
        }
    }
    
    
    func grabNextLetterToFetch() -> String{
        currentReservationsCount += 100
        
        let startPoint = editReservations.last
        var result: String!
        
        if let letters = startPoint?.fullNameReversed {
            result = String(letters.prefix(12))
        }
        return result
    }
    
    
    func handleEmptyStateResult() {
        dismissLoadingView()
        
        DispatchQueue.main.async {
            self.showEmptyStateView(with: self.emptyStateMessage, in: self.view)
            self.tableView.refreshControl?.endRefreshing()
            return
        }
    }

    
    func handleFetchResults(for reservation: EditReservation) {
        let reservationID = reservation.reservationId
        
        if let existingReservation = self.editReservations.firstIndex(where: { $0.reservationId == reservationID }) {
            self.editReservations[existingReservation] = reservation
        } else {
            self.editReservations.append(reservation)
        }
        
        self.editReservations.sort { (reservation1, reservation2) -> Bool in
            return reservation1.fullNameReversed < reservation2.fullNameReversed
        }
        tableView.reloadData()
    }
    
    
    func handleFetchEmailResult(for email: EmailList) {
        let waiverID = email.waiverID
        
        if let existingEmail = self.emailsList.firstIndex(where: { $0.waiverID == waiverID }) {
            self.emailsList[existingEmail] = email
        } else {
            self.emailsList.append(email)
        }
        
        self.emailsList.sort { (email1, email2) -> Bool in
            return email1.fullNameReversed < email2.fullNameReversed
        }
        self.tableView.reloadData()
    }
    
    
    func handleSearchResult(for name: String, in reservation: EditReservation) {
        searchedReservationResult.append(reservation)
        
        filteredReservations = searchedReservationResult.filter({ (waiver) -> Bool in
            return waiver.fullName.localizedCaseInsensitiveContains(name)
        })
        
        filteredReservations.sort { (waiver1, waiver2) -> Bool in
            return waiver1.fullNameReversed.lowercased() < waiver2.fullNameReversed.lowercased()
        }
        tableView.reloadData()
    }
    
    
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
    
    
    func removeEmailIndex(for email: DataSnapshot){
        let emailId = email.key
        guard showInformation == .EmailList else { return }
        
        if let existingIndex = self.emailsList.firstIndex(where: { $0.waiverID == emailId }) {
            let row: IndexPath = [0, existingIndex]
            self.emailsList.remove(at: existingIndex)
            self.tableView.deleteRows(at: [row], with: .fade)
        }
    }
    
    
    func removeReservationIndex(for reservation: DataSnapshot){
        let reservationID = reservation.key
        guard showInformation == .EditReservation else { return }
        
        if let existingIndex = self.editReservations.firstIndex(where: { $0.reservationId == reservationID }) {
            let row: IndexPath = [0, existingIndex]
            self.editReservations.remove(at: existingIndex)
            self.tableView.deleteRows(at: [row], with: .fade)
            print("array count is \(editReservations.count)")
        }
    }

    
    //    MARK: - API
    
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
                    self.tableView.refreshControl?.endRefreshing()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {Alert.showAlert(on: self, with: error.rawValue)}
            }
        }
    }
    
    
    func deleteReservation(with id: String, caseType: ShowInformation) {
        NetworkManager.shared.removeReservation(for: id, caseType: caseType) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                break
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func fetchReservation(limit value: Int, startAt startingPoint: String) {
           NetworkManager.shared.fetchReservation(limit: value, startingPoint: startingPoint) { [weak self] result in
               guard let self = self else { return }
               self.dismissLoadingView()
               self.tableView.refreshControl?.endRefreshing()
               
               switch result {
               case .success(let reservation):
                   self.handleFetchResults(for: reservation)
                   
               case .failure(let error):
                   DispatchQueue.main.async {Alert.showAlert(on: self, with: error.rawValue)}
               }
           }
       }
       
       
       func fetchEmailList() {
           NetworkManager.shared.fetchEmailList { [weak self] result in
               
               guard let self = self else { return }
               self.checkEmptyState(PARTICIPANT_EMAIL_REF)
               
               switch result {
               case .success(let email):
                   self.handleFetchEmailResult(for: email)
                   
               case .failure(let error):
                   DispatchQueue.main.async {Alert.showAlert(on: self, with: error.rawValue)}
               }
           }
       }
    
    
    func observeChildRemoved(_ reference: DatabaseReference) {
        NetworkManager.shared.observeChildRemoved(for: reference) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let snapshot):
                guard let snapshot = snapshot else { return }
                self.showInformation == .EditReservation ? self.removeReservationIndex(for: snapshot) : self.removeEmailIndex(for: snapshot)
               
                #warning("old method left here to use when handling empty state at a later time")
//                 self.checkEmptyState(reference)
            case .failure(_):
                break
            }
        }
    }
    
    
    func searchReservations(for name: String) {
        showLoadingView()
        
        NetworkManager.shared.searchReservations { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let reservation):
                self.handleSearchResult(for: name, in: reservation)
            case .failure(_):
                break
            }
        }
    }
    
    
}


extension EditReservationVC: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        searchReservations(for: text.lowercased())
        searchBar.resignFirstResponder()
    }

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchedReservationResult.removeAll()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText
        
        if searchText.isEmpty || searchText == " " {
            inSearchMode = false
            tableView.reloadData()
        } else {
            inSearchMode = true
            filteredReservations = editReservations.filter({ (reservation) -> Bool in
                return reservation.fullName.localizedCaseInsensitiveContains(searchText)
            })
            tableView.reloadData()
        }
    }
}
