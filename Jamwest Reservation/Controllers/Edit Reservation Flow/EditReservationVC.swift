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

class EditReservationVC: UITableViewController {

//    MARK: - Properties
    var editReservations = [EditReservation]()
    let loadingVC = LoadingVC()
    
//    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        // register cell class
        tableView.register(EditReservationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .white
        
        // separator insets
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        
        configureUI()
        fetchReservation()
        observeRemovedReservation()
    }

    //     MARK: - TableView flow layout
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return editReservations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditReservationCell

        // Configure the cell...
        cell.reservation = editReservations[indexPath.row]
        return cell
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
    }
    
//    MARK: - API
    
    func fetchReservation() {
        
        Database.fetchReservation(from: RESERVATION_REF) { (reservation) in
            
            // append waiver to data source
            self.editReservations.append(reservation)
            
            // sort results in alphabetical order
            self.editReservations.sort { (reservation1, reservation2) -> Bool in
                return reservation1.group < reservation2.group
            }
            self.tableView.reloadData()
        }
    }
    
    // updates tableView when reservation gets is removed
    func observeRemovedReservation() {
        
        RESERVATION_REF.observe(.childRemoved) { (snapshot) in
            
            self.add(self.loadingVC)
            self.editReservations.removeAll(keepingCapacity: false)
            self.fetchReservation()
            self.remove(self.loadingVC)
            self.tableView.reloadData()
        }
    }
}
