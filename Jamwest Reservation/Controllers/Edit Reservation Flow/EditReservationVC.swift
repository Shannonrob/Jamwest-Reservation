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
    var editReservations = [EditReservation]()
    var filteredReservations = [EditReservation]()
    var emailsList = [EmailList]()
    var showInformation: ShowInformation!
    var shareEmails = [EmailList]()
    var inSearchMode = false
    var isShowingReservations = true
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
        showInformation == .EditReservation ? fetchReservation() : fetchEmailList()
        showInformation == .EditReservation ? observeChildRemoved(RESERVATION_REF) : observeChildRemoved(PARTICIPANT_EMAIL_REF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showInformation == .EmailList {
            navigationItem.title = "Email List"
            configureEmailListBarButtons()
        } else {
            navigationItem.title = "Edit Reservation"
            showSearchBarButton(shouldShow: true)
        }
    }
    
    //     MARK: - TableView flow layout
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
            configureEmailListBarButtons()
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
    
    //    MARK: - Handlers
    
    @objc func handleSearch() {
        
        showSearchBar(shouldShow: true)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    @objc func handleCancelSearch() {
        
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
            fetchReservation()

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
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            
            for email in self.shareEmails {
                
                let waiverId = email.waiverID
                PARTICIPANT_EMAIL_REF.child(waiverId!).removeValue()
                self.tableView.reloadData()
            }
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
    
    func configureUI() {
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Edit Reservation"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation ,NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteBack "), style: .plain, target: self, action: #selector(handleDismiss))
    }
    
    func handleFetchResults(for reservation: EditReservation) {
        let reservationID = reservation.reservationId
        
        if let existingReservation = self.editReservations.firstIndex(where: { $0.reservationId == reservationID }) {
            self.editReservations[existingReservation] = reservation
        } else {
            self.editReservations.append(reservation)
        }
        
        self.editReservations.sort { (reservation1, reservation2) -> Bool in
            return reservation1.firstName < reservation2.firstName
        }
        tableView.reloadData()
    }
    
    func handleFetchEmailResult(for email: EmailList) {
        self.emailsList.append(email)
        
        self.emailsList.sort { (email1, email2) -> Bool in
            return email1.name < email2.name
        }
        self.tableView.reloadData()
    }
    
    func handleChildRemovedObserver() {
        switch self.showInformation {
            
        case .EditReservation:
            self.editReservations.removeAll(keepingCapacity: false)
            self.fetchReservation()
            
        case .EmailList:
            self.emailsList.removeAll(keepingCapacity: false)
            self.fetchEmailList()
            
        default:
            break
        }
        self.tableView.reloadData()
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
    
    func configureRefreshControl() {

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // highlight selected cell with custom color
    func configureSelectedCell(for cell: JamwestCell, with color: UIColor) {
        
        if cell.cellView.backgroundColor == color {
            cell.cellView.backgroundColor = .white
            cell.headerLabel.textColor = .black
            cell.detailLabel.textColor = .lightGray
        } else {
            cell.cellView.backgroundColor = color
            cell.headerLabel.textColor = .white
            cell.detailLabel.textColor = .white
        }
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
    
    // handles share and trash button appearance
    func configureEmailListBarButtons() {
        
        let trashIcon = UIImage(systemName: "trash")
        let shareIcon = UIImage(systemName: "square.and.arrow.up")
        
        if shareEmails.count >= 1{
            
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(image: trashIcon?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleDelete)),
                UIBarButtonItem(image: shareIcon?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(shareList))]
        } else {
            
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(image: trashIcon?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil),
                UIBarButtonItem(image: shareIcon?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)]
        }
    }
    
    //    MARK: - API
    
    func fetchReservation() {
        showLoadingView()
        NetworkManager.shared.fetchReservation { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            self.tableView.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let reservation):
                self.handleFetchResults(for: reservation)
                
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    func fetchEmailList() {
        showLoadingView()
        NetworkManager.shared.fetchEmailList { [weak self] result in
            
            guard let self = self else { return }
            self.dismissLoadingView()
            self.tableView.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let email):
                self.handleFetchEmailResult(for: email)
                
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func observeChildRemoved(_ reference: DatabaseReference) {
        NetworkManager.shared.observeWaiverDeletion(for: reference) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                self.handleChildRemovedObserver()
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
        searchBar.resignFirstResponder()
    }
    
    // filters search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText
        
        if searchText.isEmpty || searchText == " " {
            inSearchMode = false
            tableView.reloadData()
        } else {
            inSearchMode = true
            filteredReservations = editReservations.filter({ (reservation) -> Bool in
                return reservation.firstName.localizedCaseInsensitiveContains(searchText)
            })
            tableView.reloadData()
        }
    }
}
