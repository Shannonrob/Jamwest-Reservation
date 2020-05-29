//
//  ToursSelectionVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "TourSelectionCell"

class ToursSelectionVC: UIViewController, TourSelectionDelegate {
    
    //    MARK: - Properties
    
    var reservedPackage: ReservationPackage!
    var tourSelectionView = TourSelectionView()
    var tourSelection = [TourSelection]()
    var selectedToursArray = [TourSelection]()
    var reservationInfo = [String: Any]()
    
    var tours = ["ATV Tour": #imageLiteral(resourceName: "orangeATV"),
                 "Driving Experience": #imageLiteral(resourceName: "orangeRaceFlagIcon"),
                 "Horseback Riding": #imageLiteral(resourceName: "orangeHorseRiding"),
                 "Push Kart": #imageLiteral(resourceName: "orangeKart"),
                 "Safari Tour": #imageLiteral(resourceName: "orangeCrocodile"),
                 "Zip Line": #imageLiteral(resourceName: "orangeZipline")]
    
    
    //    MARK: - Init
    
    override func loadView() {
        super.loadView()
        tourSelectionView.delegate = self
        view = tourSelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tourSelectionView.tableView.delegate = self
        tourSelectionView.tableView.dataSource = self
        
        // register cell class
        tourSelectionView.tableView.register(TourSelectionCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        loadTourDetails()
        configureUI()
    }
    
    //    MARK: - Handlers
    
    @objc func handleCancelButton() {
        
        dismissTourSelectionVC()
    }
    
    //    MARK: - Protocols and delegate
    
    func handleSubmitButton(for vc: TourSelectionView) {
        
        reservedPackage = selectedPackage()()
        
        switch reservedPackage {
        case .SingleTour :
            
            selectedToursArray.isEmpty ? Alert.showAlert(on: self, with: "No tour selected") : nil
            
        case .ComboDeal:
            
            checkTourCount(with: selectedToursArray, for: 2)
            
        case .SuperDeal:
            
            checkTourCount(with: selectedToursArray, for: 3)
            
        case .DeluxePackage:
            checkTourCount(with: selectedToursArray, for: 4)
            
        default: break
        }
    }
    
    //    MARK: - Helper Function
    
    // closure that uses method from AddReservationVC to identify selected package
    func selectedPackage() -> () -> ReservationPackage {
        
        let addReservation = AddReservationVC()
        let tourPackage = reservationInfo[Constant.tourPackage]
        
        let configuration = { () -> ReservationPackage in
            
            let index = ReservationPackage(rawValue: addReservation.convertPackageResult(from: tourPackage as! String))!
            return index
        }
        return configuration
    }
    
    // load available tours
    func loadTourDetails() {
        
        for info in tours {
            
            let tour = TourSelection(title: info.key, image: info.value)
            
            tourSelection.append(tour)
            
            self.tourSelection.sort { (tour1, tour2) -> Bool in
                return tour1.title < tour2.title
            }
            tourSelectionView.tableView.reloadData()
        }
    }
    
    // check array count before submitting tours
    func checkTourCount(with array: [TourSelection], for value: Int) {
        
        if array.isEmpty{
            Alert.showAlert(on: self, with: "No tour selected")
        } else if array.count < value {
            Alert.showAlert(on: self, with: "Select tours")
        } else if array.count > value {
            Alert.showExceedLimitAlert(on: self)
        } else {
            
            // handle submit tours here
            print("Success")
        }
    }
    
    // filter selected tours to prevent duplicate
    func filterSelectedTours(with array: [TourSelection], for indexPath: IndexPath) {
        
        let tour = array[indexPath.row].title
        
        if let existingIndex = selectedToursArray.firstIndex(where: { $0.title == tour }) {
            
            selectedToursArray[existingIndex] = tourSelection[indexPath.row]
            
        } else {
            
            selectedToursArray.append(tourSelection[indexPath.row])
        }
    }
    
    func configureUI() {
        
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Tour selection"
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelButton))
    }
    
    // Action sheet
    func showAlertSheet(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: "Would you like to create another reservation?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            // present AddReservationVC
            let addReservationVC = AddReservationVC()
            var vcArray = self.navigationController?.viewControllers
            vcArray!.removeLast()
            vcArray!.append(addReservationVC)
            self.navigationController?.setViewControllers(vcArray!, animated: true)
        })
        
        let deleteAction = UIAlertAction(title: "No", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            
            //dismiss all viewControllers back to rootVC
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(deleteAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // dismiss toursSelectionVC
    func dismissTourSelectionVC() {
        
        let alertController = UIAlertController(title: "Warning", message: "Reservation will be deleted!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Continue", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            // dismiss tourSelectionVC
            self.dismiss(animated: true, completion: nil)
        })
        
        let deleteAction = UIAlertAction(title: "Stay here", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(deleteAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    ////    MARK: - API
    //
    ////     submit tours to firebase
    //    func submitSelectedTours() {
    //
    //        // create post ID
    //        let reservation = RESERVATION_REF.childByAutoId()
    //
    //        //push reservation info to firebase
    //        reservation.updateChildValues(reservationInfo) { (err, ref) in
    //
    //            guard let reservationID = reservation.key else { return }
    //
    //            let dateValue = [reservationID: 1] as [String: Any]
    //
    //            let date = RESERVATION_DATE_REF.child(self.reservationInfo[Constant.reservationDate] as! String)
    //            date.updateChildValues(dateValue)
    //
    //            self.showAlertSheet(self.submitButton)
    //        }
    //    }
}

extension ToursSelectionVC: UITableViewDelegate, UITableViewDataSource {
    
    //     MARK: - TableView flow layout
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //    MARK: - TableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourSelection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TourSelectionCell
        
        cell.tourSelection = tourSelection[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        reservedPackage = selectedPackage()()
        
        switch reservedPackage {
            
        // append the selected tours to array
        case .SingleTour:
            
            selectedToursArray.append(tourSelection[indexPath.row])
            selectedToursArray.count > 1 ? selectedToursArray.remove(at: 0) : nil
            
        case .ComboDeal:
            filterSelectedTours(with: tourSelection, for: indexPath)
            
        case.SuperDeal:
            filterSelectedTours(with: tourSelection, for: indexPath)
            
        case.DeluxePackage:
            filterSelectedTours(with: tourSelection, for: indexPath)
        default: break
        }
    }
}

//append tours to dictionary
//            reservationInfo.updateValue(reservationTours[0], forKey: Constant.firstTour)
//            reservationInfo.updateValue(reservationTours[1], forKey: Constant.secondTour)
//            reservationInfo.updateValue(reservationTours[2], forKey: Constant.thirdTour)
//            reservationInfo.updateValue(reservationTours[3], forKey: Constant.fourthTour)
