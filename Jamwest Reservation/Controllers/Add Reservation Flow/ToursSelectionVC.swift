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
    var tourSelectionCell: TourSelectionCell!
    var tourSelectionView = TourSelectionView()
    var tourSelection = [TourSelection]()
    var selectedToursArray = [TourSelection]()
    var reservationInfo = [String: Any]()
    var uploadAction: UploadAction!
    var reservation: Reservation!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reservedPackage == .ComboDeal ? tourSelectionView.tableView.allowsMultipleSelection = true : nil
    }
    
    //    MARK: - Handlers
    
    @objc func handleCancelButton() {
        
        dismissTourSelectionVC()
    }
    
    //    MARK: - Protocols and delegate
    
    func handleSubmitButton(for vc: TourSelectionView) {
        
        reservedPackage = packageSelected()()
        
        switch reservedPackage {
        case .SingleTour :
            checkTourCount(with: selectedToursArray, for: 1)
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
    func packageSelected() -> () -> ReservationPackage {

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
            return
        } else if array.count >= 1 && array.count < value {
            Alert.showAlert(on: self, with: "More tours required to proceed with resevered tour package.")
        } else if array.count > value {
            Alert.showExceedLimitAlert(on: self)
        } else {
            
            // add selected tour(s) value to reservationInfo
            switch reservedPackage {
            case .SingleTour:
                reservationInfo.updateValue(selectedToursArray[0].title as String, forKey: Constant.firstTour)
            case .ComboDeal:
                reservationInfo.updateValue(selectedToursArray[0].title as String, forKey: Constant.firstTour)
                reservationInfo.updateValue(selectedToursArray[1].title as String, forKey: Constant.secondTour)
            case .SuperDeal:
                reservationInfo.updateValue(selectedToursArray[0].title as String, forKey: Constant.firstTour)
                reservationInfo.updateValue(selectedToursArray[1].title as String, forKey: Constant.secondTour)
                reservationInfo.updateValue(selectedToursArray[2].title as String, forKey: Constant.thirdTour)
            case .DeluxePackage:
                reservationInfo.updateValue(selectedToursArray[0].title as String, forKey: Constant.firstTour)
                reservationInfo.updateValue(selectedToursArray[1].title as String, forKey: Constant.secondTour)
                reservationInfo.updateValue(selectedToursArray[2].title as String, forKey: Constant.thirdTour)
                reservationInfo.updateValue(selectedToursArray[3].title as String, forKey: Constant.fourthTour)
            default: break
            }
            
            // create or save reservation
            uploadAction == .UploadReservation ? createReservation() : saveReservationChanges()
        }
    }
    
    // filter selected tours to prevent duplicate and append to array
    func filterSelectedTours(with array: [TourSelection], for indexPath: IndexPath) {
        
        let tour = array[indexPath.row].title
        
        if selectedToursArray.firstIndex(where: { $0.title == tour }) != nil {
            selectedToursArray.removeAll{ $0.title == tour }
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
    func showReservationCreatedAlert() {
        
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
    
    // highlight selected cell with custom color
    func configureSelectedCell(for cell: TourSelectionCell) {
        
        if cell.cellView.backgroundColor == Color.Primary.orange {
            cell.cellView.backgroundColor = .white
            cell.tourLabel.textColor = .black
            cell.tourLabel.font = UIFont.systemFont(ofSize: 24)
        } else {
            cell.cellView.backgroundColor = Color.Primary.orange
            cell.tourLabel.textColor = .white
            cell.tourLabel.font = UIFont.boldSystemFont(ofSize: 24)
        }
    }
    
    //    MARK: - API
    
    func createReservation() {
        
        // create post ID
        let reservation = RESERVATION_REF.childByAutoId()
        
        //push reservation info to firebase
        reservation.updateChildValues(reservationInfo) { (err, ref) in
            
            guard let reservationID = reservation.key else { return }
            
            let dateValue = [reservationID: 1] as [String: Any]
            
            let date = RESERVATION_DATE_REF.child(self.reservationInfo[Constant.reservationDate] as! String)
            
            date.updateChildValues(dateValue) { (err, ref) in
            
                if let err = err {
                    Alert.showAlert(on: self, with: err.localizedDescription)
                } else {
                    self.showReservationCreatedAlert()
                }
            }
        }
    }
    
    func saveReservationChanges() {
        
        guard let reservationId = reservation.reservationId else { return }
        
        RESERVATION_REF.child(reservationId).updateChildValues(reservationInfo) { (error, ref) in
            
            if let err = error {
                Alert.showAlert(on: self, with: err.localizedDescription)
            } else {
                self.showReservationCreatedAlert()
            }
        }
    }
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
        let selectedCell: TourSelectionCell = tableView.cellForRow(at: indexPath) as! TourSelectionCell
        
        configureSelectedCell(for: selectedCell)
        filterSelectedTours(with: tourSelection, for: indexPath)
    }
}

