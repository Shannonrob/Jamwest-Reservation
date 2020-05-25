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
    var emailsList = [EmailList]()
    let loadingVC = LoadingVC()
    var showInformation: ShowInformation!
    
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
        
        // fetch data based on enum case
        showInformation == .EditReservation ? fetchReservation() : fetchEmailList()
        showInformation == .EditReservation ? observeChildRemoved(RESERVATION_REF) : observeChildRemoved(PARTICIPANT_EMAIL_REF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if showInformation == .EmailList {
            navigationItem.title = "Email List"
        } else {
            navigationItem.title = "Edit Reservation"
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
            return editReservations.count
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
            
            // Configure the cell...
            cell.reservation = editReservations[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        presentAddReservationVC(index: 1, with: editReservations[indexPath.row] )
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    //    MARK: - Handlers
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func shareList() {
        
        let item = "Russo look what I did!!!"
        
        let vc = UIActivityViewController(activityItems: [item], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    //    MARK: - Helper functions
    
    func configureUI() {
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Edit Reservation"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteBack "), style: .plain, target: self, action: #selector(handleDismiss))
        
        showInformation == .EmailList ? navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList)) : nil
    }
    
    //    MARK: - API
    
    func fetchReservation() {
        
        Database.fetchReservation(from: RESERVATION_REF) { (reservation) in
            
            // append waiver to data source
            self.editReservations.append(reservation as! EditReservation)
            
            // sort results in alphabetical order
            self.editReservations.sort { (reservation1, reservation2) -> Bool in
                return reservation1.date > reservation2.date && reservation1.group < reservation2.group
            }
            self.tableView.reloadData()
        }
    }
    
    func fetchEmailList() {
        
        Database.fetchEmailList(from: PARTICIPANT_EMAIL_REF) { (email) in
            
            self.emailsList.append(email)
            
            self.emailsList.sort { (email1, email2) -> Bool in
                return email1.name < email2.name
            }
            self.tableView.reloadData()
        }
    }
    
    // updates tableView when child is removed
    func observeChildRemoved(_ reference: DatabaseReference) {
        
        reference.observe(.childRemoved) { (snapshot) in
            
            self.add(self.loadingVC)
            
            // switch observer based on showInformation case
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
            self.remove(self.loadingVC)
            self.tableView.reloadData()
        }
    }
}
