//
//  ToursSelectionVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class ToursSelectionVC: UIViewController {
    
//    MARK: - Properties
    
    var singleTourPackageSelection = String()
    var comboDealToursArray = [UIButton]()
    var superDealPackageArray = [UIButton]()
    var deluxePackageArray = [UIButton]()
    var reservationTours = [String]()
    lazy var tourPackage = String()
    var reservedToursDictionary = [:] as [String: Any]
    var reservationInfo = [String: Any]()
    
//    MARK: - Labels
    
    let tourLabel: UILabel = {
        let label = UILabel()
        label.text = "Please select reserved tours"
        label.textColor = .darkText
        label.font = UIFont(name: avenirNext_Regular, size: 32)
        return label
    }()
    
//    MARK: - Buttons
    
   let atvTourButton: UIButton = {
       let button = UIButton(type: .system)
       button.configureButtonWithIcon("orangeATV", title: "ATV Tour", titleColor: .gray, buttonColor: .white, cornerRadius: 6)
       button.titleLabel?.font = .systemFont(ofSize: 24)
       button.layer.borderWidth = 0.80
       button.layer.borderColor = UIColor.lightGray.cgColor
       button.addTarget(self, action: #selector(handleATVTour), for: .touchUpInside)
       return button
   }()
   
   let horseBackRidingTourButton: UIButton = {
       let button = UIButton(type: .system)
       button.configureButtonWithIcon("orangeHorseRiding", title: "Horseback", titleColor: .gray, buttonColor: .white, cornerRadius: 6)
       button.titleLabel?.font = .systemFont(ofSize: 24)
       button.layer.borderWidth = 0.80
       button.layer.borderColor = UIColor.lightGray.cgColor
       button.addTarget(self, action: #selector(handleHorseBackRidingTour), for: .touchUpInside)
       return button
   }()
   
   let safariTourButton: UIButton = {
       let button = UIButton(type: .system)
       button.configureButtonWithIcon("orangeCrocodile", title: "Safari Tour", titleColor: .gray, buttonColor: .white, cornerRadius: 6)
       button.titleLabel?.font = .systemFont(ofSize: 24)
       button.layer.borderWidth = 0.80
       button.layer.borderColor = UIColor.lightGray.cgColor
       button.addTarget(self, action: #selector(handleSafariTour), for: .touchUpInside)
       return button
   }()
   
   let zipLineTourButton: UIButton = {
       let button = UIButton(type: .system)
       button.configureButtonWithIcon("orangeZipline", title: "Zip Line", titleColor: .gray, buttonColor: .white, cornerRadius: 6)
       button.titleLabel?.font = .systemFont(ofSize: 24)
       button.layer.borderWidth = 0.80
       button.layer.borderColor = UIColor.lightGray.cgColor
       button.addTarget(self, action: #selector(handleZiplineTour), for: .touchUpInside)
       return button
   }()
   
   let pushKartTourButton: UIButton = {
       let button = UIButton(type: .system)
       button.configureButtonWithIcon("orangeKart", title: "Push Kart", titleColor: .gray, buttonColor: .white, cornerRadius: 6)
       button.titleLabel?.font = .systemFont(ofSize: 24)
       button.layer.borderWidth = 0.80
       button.layer.borderColor = UIColor.lightGray.cgColor
       button.addTarget(self, action: #selector(handlePushKartTour), for: .touchUpInside)
       return button
   }()
    
    let drivingExperienceButton: UIButton = {
        let button = UIButton(type: .system)
        button.configureButtonWithIcon(orange_Race_Flag_Icon, title: "Driving Experience", titleColor: .gray, buttonColor: .white, cornerRadius: 6)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.layer.borderWidth = 0.80
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(handleDrivingExperienceTour), for: .touchUpInside)
        return button
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.backgroundColor = Constants.Design.Color.FadedHue.Green
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSubmitButton), for: .touchUpInside)
        return button
   }()
   
    
//    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

       configureUI()
       updateTourLabel()
       setConstraints()
    }
    
//    MARK: - Selectors
    
    @objc func handleCancelButton() {

        dismissTourSelectionVC(navigationItem.leftBarButtonItem!)
    }
    
    @objc func handleBackButton() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleATVTour() {
    
        updateSelectionFont(button: atvTourButton)
        
        switch tourPackage {
            
        case single_Tour:
            drivingExperienceButton.isSelected = false
            drivingExperienceButton.titleLabel?.font = .systemFont(ofSize: 24)
            horseBackRidingTourButton.isSelected = false
            horseBackRidingTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            pushKartTourButton.isSelected = false
            pushKartTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            safariTourButton.isSelected = false
            safariTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            zipLineTourButton.isSelected = false
            zipLineTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            singleTourPackageSelection = atvTourButton.currentTitle!
            configureSingleTourPackageSelection()
        
        case combo_Deal:
            updateComboDealArray(button: atvTourButton)
            configureComboDealPackageTours()
            
        case super_Deal:
            updateSuperDealArray(button: atvTourButton)
            configureSuperDealPackageTours()
            
        case deluxe_Package:
            updateDeluxePackageArray(button: atvTourButton)
            configureDeluxePackageTours()
            
        default:
            return
        }
    }
    
    @objc func handleDrivingExperienceTour() {
          
          updateSelectionFont(button: drivingExperienceButton)
          
          switch tourPackage {
              
          case single_Tour:
              atvTourButton.isSelected = false
              atvTourButton.titleLabel?.font = .systemFont(ofSize: 24)
              horseBackRidingTourButton.isSelected = false
              horseBackRidingTourButton.titleLabel?.font = .systemFont(ofSize: 24)
              pushKartTourButton.isSelected = false
              pushKartTourButton.titleLabel?.font = .systemFont(ofSize: 24)
              safariTourButton.isSelected = false
              safariTourButton.titleLabel?.font = .systemFont(ofSize: 24)
              singleTourPackageSelection = drivingExperienceButton.currentTitle!
              configureSingleTourPackageSelection()
              
          case combo_Deal:
              updateComboDealArray(button: drivingExperienceButton)
              configureComboDealPackageTours()
              
          case super_Deal:
              updateSuperDealArray(button: drivingExperienceButton)
              configureSuperDealPackageTours()
              
          case deluxe_Package:
              updateDeluxePackageArray(button: drivingExperienceButton)
              configureDeluxePackageTours()
              
          default:
              return
          }
      }
    
    @objc func handleHorseBackRidingTour() {
        
        updateSelectionFont(button: horseBackRidingTourButton)
    
        switch tourPackage {
            
        case single_Tour:
            atvTourButton.isSelected = false
            atvTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            drivingExperienceButton.isSelected = false
            drivingExperienceButton.titleLabel?.font = .systemFont(ofSize: 24)
            pushKartTourButton.isSelected = false
            pushKartTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            safariTourButton.isSelected = false
            safariTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            zipLineTourButton.isSelected = false
            zipLineTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            singleTourPackageSelection = horseBackRidingTourButton.currentTitle!
            configureSingleTourPackageSelection()
            
        case combo_Deal:
            updateComboDealArray(button: horseBackRidingTourButton)
            configureComboDealPackageTours()
            
        case super_Deal:
            updateSuperDealArray(button: horseBackRidingTourButton)
            configureSuperDealPackageTours()
            
        case deluxe_Package:
            updateDeluxePackageArray(button: horseBackRidingTourButton)
            configureDeluxePackageTours()
            
        default:
            return
        }
    }
    
    @objc func handlePushKartTour() {
    
        updateSelectionFont(button: pushKartTourButton)
        
        switch tourPackage {
            
        case single_Tour:
            atvTourButton.isSelected = false
            atvTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            drivingExperienceButton.isSelected = false
            drivingExperienceButton.titleLabel?.font = .systemFont(ofSize: 24)
            horseBackRidingTourButton.isSelected = false
            horseBackRidingTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            safariTourButton.isSelected = false
            safariTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            zipLineTourButton.isSelected = false
            zipLineTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            singleTourPackageSelection = pushKartTourButton.currentTitle!
            configureSingleTourPackageSelection()
            
        case combo_Deal:
            updateComboDealArray(button: pushKartTourButton)
            configureComboDealPackageTours()
            
        case super_Deal:
            updateSuperDealArray(button: pushKartTourButton)
            configureSuperDealPackageTours()
            
        case deluxe_Package:
            updateDeluxePackageArray(button: pushKartTourButton)
            configureDeluxePackageTours()
            
        default:
            return
        }
    }
    
    @objc func handleSafariTour() {
    
        updateSelectionFont(button: safariTourButton)
        
        switch tourPackage {
            
        case single_Tour:
            atvTourButton.isSelected = false
            atvTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            drivingExperienceButton.isSelected = false
            drivingExperienceButton.titleLabel?.font = .systemFont(ofSize: 24)
            horseBackRidingTourButton.isSelected = false
            horseBackRidingTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            pushKartTourButton.isSelected = false
            pushKartTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            zipLineTourButton.isSelected = false
            zipLineTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            singleTourPackageSelection = safariTourButton.currentTitle!
            configureSingleTourPackageSelection()
        
        case combo_Deal:
            updateComboDealArray(button: safariTourButton)
            configureComboDealPackageTours()
            
        case super_Deal:
            updateSuperDealArray(button: safariTourButton)
            configureSuperDealPackageTours()
            
        case deluxe_Package:
            updateDeluxePackageArray(button: safariTourButton)
            configureDeluxePackageTours()
            
        default:
            return
        }
    }
    
    @objc func handleZiplineTour() {
    
        updateSelectionFont(button: zipLineTourButton)
        
        switch tourPackage {
            
        case single_Tour:
            atvTourButton.isSelected = false
            atvTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            drivingExperienceButton.isSelected = false
            drivingExperienceButton.titleLabel?.font = .systemFont(ofSize: 24)
            horseBackRidingTourButton.isSelected = false
            horseBackRidingTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            pushKartTourButton.isSelected = false
            pushKartTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            safariTourButton.isSelected = false
            safariTourButton.titleLabel?.font = .systemFont(ofSize: 24)
            singleTourPackageSelection = zipLineTourButton.currentTitle!
            configureSingleTourPackageSelection()
            
        case combo_Deal:
            updateComboDealArray(button: zipLineTourButton)
            configureComboDealPackageTours()
            
        case super_Deal:
            updateSuperDealArray(button: zipLineTourButton)
            configureSuperDealPackageTours()
            
        case deluxe_Package:
            updateDeluxePackageArray(button: zipLineTourButton)
            configureDeluxePackageTours()
            
        default:
            return
        }
    }
    
    
    @objc func handleSubmitButton() {
        
        selectedTours()
    }
    
//    MARK: - Helper Functions
  
    // checking array for selected buttons
    func checkSelectedTours(forArray array:Array<UIButton>) {
        
        for tours in array {
        reservationTours.append(tours.currentTitle!)
       }
    }
    
    func selectedTours() {
   
       switch tourPackage {
           
       case single_Tour:
        // catching the selected tour
           reservationTours = [singleTourPackageSelection]
           
           //append tour to dictionary
           reservedToursDictionary.updateValue(reservationTours[0], forKey: first_Tour)
           
           //method for pushing selected tours to database
           submitSelectedTours()
        
       case combo_Deal:
           
           // check if package selections is greater than package limit
           if comboDealToursArray.count > 2 {
               Alert.showOverLimitComboDealTourSelections(on: self)
           } else {
            checkSelectedTours(forArray: comboDealToursArray)
            
            //append tours to dictionary
            reservedToursDictionary.updateValue(reservationTours[0], forKey: first_Tour)
            reservedToursDictionary.updateValue(reservationTours[1], forKey: second_Tour)
            
            //method for pushing selected tours to database
            submitSelectedTours()
           }
           
       case super_Deal:
           
           // check if package selections is greater than package limit
           if superDealPackageArray.count > 3 {
               Alert.showOverLimitSuperDealTourSelections(on: self)
           } else {
            checkSelectedTours(forArray: superDealPackageArray)
            
            //append tours to dictionary
            reservedToursDictionary.updateValue(reservationTours[0], forKey: first_Tour)
            reservedToursDictionary.updateValue(reservationTours[1], forKey: second_Tour)
            reservedToursDictionary.updateValue(reservationTours[2], forKey: third_Tour)
            
            //method for pushing selected tours to database
            submitSelectedTours()
           }
           
       case deluxe_Package:
           
           // check if package selections is greater than package limit
           if deluxePackageArray.count > 4 {
               Alert.showOverLimitDeluxePackageTourSelections(on: self)
           } else {
            checkSelectedTours(forArray: deluxePackageArray)
            
            //append tours to dictionary
            reservedToursDictionary.updateValue(reservationTours[0], forKey: first_Tour)
            reservedToursDictionary.updateValue(reservationTours[1], forKey: second_Tour)
            reservedToursDictionary.updateValue(reservationTours[2], forKey: third_Tour)
            reservedToursDictionary.updateValue(reservationTours[3], forKey: forth_Tour)

            //method for pushing selected tours to database
            submitSelectedTours()
           }
       default:
           return
       }
    }
    
    func updateTourLabel() {
        // get selected tour package
        tourPackage = reservationInfo[tour_Package] as! String
        
        if tourPackage == single_Tour {
            tourLabel.text = "Please select reserved tour"
        }
    }
    
    func configureUI() {
        
        view.backgroundColor = Constants.Design.Color.Background.FadeGray
        
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.Primary.HeavyGreen
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Tour selection"
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteBack "), style: .plain, target: self, action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    
    func setConstraints() {
    
        view.addSubview(tourLabel)
        tourLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tourLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [atvTourButton, drivingExperienceButton, horseBackRidingTourButton, pushKartTourButton, safariTourButton, zipLineTourButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: tourLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom:0, paddingRight: 15, width: 0, height: 300)
        
        view.addSubview(submitButton)
        submitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 50, paddingRight: 15, width: 0, height: 60)
    }
    
//    Function to update font style on button selection
    func updateSelectionFont(button: UIButton) {
       
        if !button.isSelected == true {
            button.isSelected = true
            button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        } else {
            button.isSelected = false
            button.titleLabel?.font = .systemFont(ofSize: 24)
        }
    }
    
//    Function to add or remove from ComboDeal Array
    func updateComboDealArray(button: UIButton) {
        
        if !comboDealToursArray.contains(button) {
            comboDealToursArray.append(button)
            button.isSelected = true
        } else {
            comboDealToursArray.remove(object: button)
            button.isSelected = false
            button.titleLabel?.font = .systemFont(ofSize: 24)
        }
    }
    
    //    Function to add or remove from SuperDeal Array
    func updateSuperDealArray(button: UIButton) {
        
        if !superDealPackageArray.contains(button) {
            superDealPackageArray.append(button)
            button.isSelected = true
        } else {
            superDealPackageArray.remove(object: button)
            button.isSelected = false
            button.titleLabel?.font = .systemFont(ofSize: 24)
        }
    }
    
    //    Function to add or remove from SuperDeal Array
       func updateDeluxePackageArray(button: UIButton) {
           
           if !deluxePackageArray.contains(button) {
               deluxePackageArray.append(button)
               button.isSelected = true
           } else {
               deluxePackageArray.remove(object: button)
               button.isSelected = false
               button.titleLabel?.font = .systemFont(ofSize: 24)
           }
       }
    
    func activateSubmitButton() {
        submitButton.isEnabled = true
        submitButton.backgroundColor = Constants.Design.Color.Hue.Green
    }

    func configureSingleTourPackageSelection() {
        
        activateSubmitButton()
        guard atvTourButton.isSelected || drivingExperienceButton.isSelected || horseBackRidingTourButton.isSelected || pushKartTourButton.isSelected || safariTourButton.isSelected || zipLineTourButton.isSelected == true else {
        submitButton.backgroundColor = Constants.Design.Color.FadedHue.Green
        submitButton.isEnabled = false
        return
        }
    }
    
    func configureComboDealPackageTours() {
        
        activateSubmitButton()
        guard comboDealToursArray.count >= 2 else {
        submitButton.backgroundColor = Constants.Design.Color.FadedHue.Green
        submitButton.isEnabled = false
        return
        }
    }
    
    func configureSuperDealPackageTours() {
        
        activateSubmitButton()
        guard superDealPackageArray.count >= 3 else {
        submitButton.backgroundColor = Constants.Design.Color.FadedHue.Green
        submitButton.isEnabled = false
        return
        }
    }
    
    func configureDeluxePackageTours() {
        
        activateSubmitButton()
        guard deluxePackageArray.count >= 4 else {
        submitButton.backgroundColor = Constants.Design.Color.FadedHue.Green
        submitButton.isEnabled = false
        return
        }
    }
    
    func showAddReservationVC() {
        //
        let addReservationVC = AddReservationVC()
        
        var vcArray = self.navigationController?.viewControllers
        vcArray!.removeLast()
        vcArray!.append(addReservationVC)
        self.navigationController?.setViewControllers(vcArray!, animated: true)
    }
    
    // Action sheet
    func showAlertSheet(_ sender: UIButton) {

        let alertController = UIAlertController(title: nil, message: "Would you like to create another reservation?", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Yes", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            // present AddReservationVC
            self.showAddReservationVC()
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
    func dismissTourSelectionVC(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Warning", message: "Reservation will be incomplete!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Leave", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
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
    
//    MARK: - API
    
//     submit tours to firebase
    func submitSelectedTours() {
        
        // create post ID
        let reservation = RESERVATION_REF.childByAutoId()

        //push reservation info to firebase
        reservation.updateChildValues(reservationInfo) { (err, ref) in

            guard let reservationID = reservation.key else { return }

            let dateValue = [reservationID: 1] as [String: Any]

            let date = RESERVATION_DATE_REF.child(self.reservationInfo[reservation_Date] as! String)
            date.updateChildValues(dateValue)

            let tours = RESERVATION_TOURS_REF.child(reservationID)
            tours.updateChildValues(self.reservedToursDictionary) { (err, ref) in

                self.showAlertSheet(self.submitButton)
            }
        }
    }
}
