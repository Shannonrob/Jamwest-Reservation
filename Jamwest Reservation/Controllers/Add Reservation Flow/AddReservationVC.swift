//
//  AddReservationVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class AddReservationVC: UIViewController, UITextFieldDelegate, AddReservationDelegate {
    
    //    MARK: - Properties
    
    var uploadAction: UploadAction!
    var reservation: Reservation!
    var addReservationView = AddReservationView()
    let reservationPackage = ReservationPackage.self

    var reservedPackage = String()
    var previousReservationDate: String!
    var savedReservationDate: String!
    
     let datePicker: UIDatePicker = {
           
           var calendar: Calendar = Calendar.current
           let currentDate: Date = Date()
           var dateComponents: DateComponents = DateComponents()
           
           calendar.timeZone = TimeZone(identifier: "EST")!
           dateComponents.calendar = calendar
           dateComponents.year = +1
           
           let maxDate: Date = calendar.date(byAdding: dateComponents, to: currentDate)!
           let datePicker = UIDatePicker()
           datePicker.datePickerMode = .dateAndTime
           datePicker.minimumDate = .some(currentDate as Date)
           datePicker.maximumDate = maxDate
           
           datePicker.backgroundColor = .white
           datePicker.setValue(UIColor.black, forKey: "textColor")
           
           return datePicker
       }()
 
    
    //    MARK: - Init
    
    override func loadView() {
        super.loadView()
        
        addReservationView.delegate = self
        view = addReservationView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addReservationView.firstNameTextField.becomeFirstResponder()
        textFieldDelegates()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        uploadAction == .SaveChanges ? restrictChanges(for:
            [addReservationView.hotelNameTextField,
             addReservationView.firstNameTextField,
             addReservationView.lastNameTextField,
             addReservationView.vourcherTextfield]) : nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uploadAction == .SaveChanges ? configureEditMode() : nil
    }
    
    
    //    MARK: - Handlers
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNextButton() {
        presentToursSelectionVC()
    }
    
    
    // add datePicker to popover
    @objc func configureDatePicker() {
        
        addReservationView.reservationDateTextfield.resignFirstResponder()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolBar.barStyle = UIBarStyle.default
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleDateSelection))
        toolBar.barTintColor = .lightGray
        toolBar.tintColor = Color.Primary.purple
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        let datePickerSize = CGSize(width: datePicker.frame.width, height: 300)
        
        let popoverView = UIView()
        popoverView.backgroundColor = .white
        let popoverViewController = UIViewController()
        
        popoverView.addSubview(toolBar)
        popoverView.addSubview(datePicker)
        
        popoverViewController.view = popoverView
        popoverViewController.modalPresentationStyle = .popover
        popoverViewController.view.frame = CGRect(x: 0, y: 0, width: datePickerSize.width, height: datePickerSize.height)
        popoverViewController.preferredContentSize = datePickerSize
        popoverViewController.popoverPresentationController?.sourceView = addReservationView.reservationDateTextfield
        popoverViewController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 51, width: addReservationView.reservationDateTextfield.bounds.width, height: 0)
        popoverViewController.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
        
        toolBar.anchor(top: popoverView.topAnchor, left: popoverView.leftAnchor, bottom: nil, right: popoverView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: datePicker.frame.width, height: 60)
        datePicker.anchor(top: toolBar.bottomAnchor, left: popoverView.leftAnchor, bottom: popoverView.bottomAnchor, right: popoverView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.present(popoverViewController, animated: true, completion: nil)
    }
    
    
    @objc func handleDateSelection() {
        
        // populate textfield with selected date and time
        addReservationView.reservationDateTextfield.text = dateFormatter(for: Event.full, with: datePicker.date)
        
        formValidation()
        addReservationView.reservationDateTextfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeDate"))
        
        if !addReservationView.tourRepTextfield.hasText {
            addReservationView.tourRepTextfield.becomeFirstResponder()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // delete contents of textfield
    @objc func handleClearTextField() {
        
        if addReservationView.hotelNameTextField.isFirstResponder {
            addReservationView.hotelNameTextField.text?.removeAll()
        } else if addReservationView.firstNameTextField.isFirstResponder {
            addReservationView.firstNameTextField.text?.removeAll()
        }else if addReservationView.lastNameTextField.isFirstResponder {
            addReservationView.lastNameTextField.text?.removeAll()
        } else if addReservationView.vourcherTextfield.isFirstResponder {
            addReservationView.vourcherTextfield.text?.removeAll()
        } else if addReservationView.tourRepTextfield.isFirstResponder {
            addReservationView.tourRepTextfield.text?.removeAll()
        } else {
            addReservationView.tourCompanyTextfield.text?.removeAll()
        }
    }
    
    
    //    MARK: - Protocols and delegates
    
    func handleFormValidation(for vc: AddReservationView, with sender: NSObject) {
        formValidation()
    }
    
    func handleShowDatePicker(for vc: AddReservationView) {
        configureDatePicker()
    }
    
    func handleStepperTapped(for vc: AddReservationView) {
        vc.stepperValueLabel.text =  "\((Int(vc.paxStepper.value )))"
    }
    
    
    // handles selected package
    func handleSegmentControl(for vc: AddReservationView){
        
        switch vc.segmentedContol.selectedSegmentIndex {
            
        case 0:
            reservedPackage = reservationPackage.SingleTour.description
        case 1:
            reservedPackage = reservationPackage.ComboDeal.description
        case 2:
            reservedPackage = reservationPackage.SuperDeal.description
        case 3:
            reservedPackage = reservationPackage.DeluxePackage.description
        default:
            reservedPackage = reservationPackage.SingleTour.description
        }
    }
    
    
    //    MARK: - Helper Functions
    
    func textFieldDelegates() {
        
        addReservationView.hotelNameTextField.delegate = self
        addReservationView.reservationDateTextfield.delegate = self
        addReservationView.firstNameTextField.delegate = self
        addReservationView.lastNameTextField.delegate = self
        addReservationView.tourRepTextfield.delegate = self
        addReservationView.vourcherTextfield.delegate = self
        addReservationView.tourCompanyTextfield.delegate = self
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if addReservationView.hotelNameTextField.isEditing ||
            addReservationView.firstNameTextField.isEditing ||
            addReservationView.lastNameTextField.isEditing ||
            addReservationView.vourcherTextfield.isEditing ||
            addReservationView.tourRepTextfield.isEditing ||
            addReservationView.tourCompanyTextfield.isEditing {
            
            addReservationView.reservationDateTextfield.isEnabled = false
        }
        //adds clear button icon to textfield
        textField.addClearButtonIcon()
        
        // add gesture to clear button icon
        let clearTextfieldGesture = UITapGestureRecognizer(target: self, action: #selector(handleClearTextField))
        clearTextfieldGesture.numberOfTapsRequired = 1
        textField.rightView?.addGestureRecognizer(clearTextfieldGesture)
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        addReservationView.reservationDateTextfield.isEnabled = true
        return true
    }
    
    
    // reinstantiate each icon after editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case addReservationView.hotelNameTextField:
            addReservationView.hotelNameTextField.setTextfieldIcon(#imageLiteral(resourceName: "orangeHotel"))
        case addReservationView.firstNameTextField:
            addReservationView.firstNameTextField.setTextfieldIcon(#imageLiteral(resourceName: "orangeName"))
        case addReservationView.lastNameTextField:
            addReservationView.lastNameTextField.setTextfieldIcon(#imageLiteral(resourceName: "orangeName"))
        case addReservationView.vourcherTextfield:
            addReservationView.vourcherTextfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeNumber"))
        case addReservationView.tourRepTextfield:
            addReservationView.tourRepTextfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeRepresentative"))
        case addReservationView.tourCompanyTextfield:
            addReservationView.tourCompanyTextfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeBus"))
        default:
            break
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case addReservationView.firstNameTextField:
            addReservationView.lastNameTextField.becomeFirstResponder()
        case addReservationView.lastNameTextField:
            addReservationView.hotelNameTextField.becomeFirstResponder()
        case addReservationView.hotelNameTextField:
            textField.resignFirstResponder()
            addReservationView.reservationDateTextfield.becomeFirstResponder()
        case addReservationView.reservationDateTextfield:
            addReservationView.tourRepTextfield.becomeFirstResponder()
        case addReservationView.tourRepTextfield:
            addReservationView.tourCompanyTextfield.becomeFirstResponder()
        case addReservationView.tourCompanyTextfield:
            addReservationView.vourcherTextfield.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    // Use this if you have a UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under 16 characters
        switch textField {
        case addReservationView.hotelNameTextField,
             addReservationView.firstNameTextField,
             addReservationView.lastNameTextField,
             addReservationView.vourcherTextfield:
            return updatedText.count <= 36
            
        case addReservationView.tourRepTextfield:
            return updatedText.count <= 27
        case addReservationView.tourCompanyTextfield:
            return updatedText.count <= 30
        default:
            break
        }
        return true
    }
    
    
    //    MARK: - Configuration
    
    func configureUI() {
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Add Reservation"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        
        let reservation = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: reservation, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "whiteDismiss ").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(handleNextButton))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    
    //format date and return string value
    func dateFormatter(for event: String, with date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        var result: String!
        
        switch event {
            
        case Event.date :
            dateFormatter.dateStyle = .medium
            result = dateFormatter.string(from: date)
            
        case Event.time :
            dateFormatter.timeStyle = .short
            result = dateFormatter.string(from: date)
            
        case Event.full :
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            result = dateFormatter.string(from: date)
            
        default: break
        }
        
        return result
    }
    
    
    // check if all textfield has contents before
    func formValidation() {
        
        guard let firstName = addReservationView.firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let lastName = addReservationView.lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        guard addReservationView.hotelNameTextField.hasText,
            addReservationView.reservationDateTextfield.hasText,
            !firstName.isEmpty,
            !lastName.isEmpty,
            addReservationView.vourcherTextfield.hasText,
            addReservationView.tourRepTextfield.hasText,
            addReservationView.tourCompanyTextfield.hasText else {
                
                navigationItem.rightBarButtonItem?.isEnabled = false
                return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    
    // converts selected package and return an int
    func convertPackageResult(from package: String) -> Int {
        
        switch package {
        case reservationPackage.SingleTour.description :
            return 0
        case reservationPackage.ComboDeal.description :
            return 1
        case reservationPackage.SuperDeal.description :
            return 2
        case reservationPackage.DeluxePackage.description :
            return 3
        default:
            return 0
        }
    }
    
    
    // passingData to ToursSelectionVC
    func presentToursSelectionVC() {
        
        let toursSelectionVC = ToursSelectionVC()
        
        guard let hotel = addReservationView.hotelNameTextField.text,
            let firstName = addReservationView.firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines ),
            let lastName = addReservationView.lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let voucherNumber = addReservationView.vourcherTextfield.text,
            let tourRep = addReservationView.tourRepTextfield.text,
            let tourCompany = addReservationView.tourCompanyTextfield.text else { return }
        
        let paxQuantity = addReservationView.paxStepper.value
        let time = dateFormatter(for: Event.time, with: datePicker.date)
        let newReservationDate = dateFormatter(for: Event.date, with: datePicker.date)
        
        // if empty add default tour
        reservedPackage.isEmpty ? reservedPackage = reservationPackage.SingleTour.description : nil
        
        // pass data based on condition
        switch uploadAction {
            
        case .UploadReservation:
            toursSelectionVC.uploadAction = UploadAction.init(index: 0)
            toursSelectionVC.reservationInfo = [ Constant.hotelName: hotel.capitalizingFirstLetter(),
                                                 Constant.firstName: firstName.capitalizingFirstLetter(),
                                                 Constant.lastName: lastName.capitalizingFirstLetter(),
                                                 Constant.fullName: "\(firstName.lowercased()) \(lastName.lowercased())",
                                                 Constant.fullNameReversed: "\(lastName.lowercased()) \(firstName.lowercased())",
                                                 Constant.voucherNumber: voucherNumber,
                                                 Constant.tourRep: tourRep.capitalizingFirstLetter(),
                                                 Constant.tourCompany: tourCompany.capitalizingFirstLetter(),
                                                 Constant.reservationTime: time,
                                                 Constant.tourPackage: reservedPackage,
                                                 Constant.reservationDate: newReservationDate,
                                                 Constant.paxCount: paxQuantity ] as [String: Any]
            
        case .SaveChanges:
            var updatedReservationInfo: [String: Any]
            
            guard let currentPackage = reservation.package else { return }
            let editedReservationDate = addReservationView.reservationDateTextfield.text
            
            if savedReservationDate != editedReservationDate {
                toursSelectionVC.isDateChanged = true
                updatedReservationInfo = [ Constant.reservationTime: time,
                                           Constant.reservationDate: newReservationDate,
                                           Constant.tourRep: tourRep,
                                           Constant.tourCompany: tourCompany,
                                           Constant.tourPackage: currentPackage]
            } else {
                toursSelectionVC.isDateChanged = false
                updatedReservationInfo = [ Constant.tourRep: tourRep,
                                           Constant.tourCompany: tourCompany,
                                           Constant.tourPackage: currentPackage]
            }
            
            toursSelectionVC.uploadAction = UploadAction.init(index: 1)
            toursSelectionVC.reservation = reservation
            toursSelectionVC.reservationInfo = updatedReservationInfo
        default: break
        }
        navigationController?.pushViewController(toursSelectionVC, animated: true)
    }
    
    //    MARK: - Edit reservation mode
    
    // converts string type to date
    func convertToDate(with date: String) -> Date {
        
        let date = date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "en_US")
        return (formatter.date(from: date) ?? nil)!
    }
    
    
    // method used to changed the appearance of the restricted UIComponent
    func restrictChanges(for textfield: [UITextField]) {
        
        for item in textfield {
            item.backgroundColor = UIColor.white.withAlphaComponent(0.60)
            item.textColor = .gray
            item.isUserInteractionEnabled = false
        }
        addReservationView.paxStepper.isUserInteractionEnabled = false
        addReservationView.segmentedContol.isUserInteractionEnabled = false
    }
    
    
    // get data for reservation to be edited
    func configureEditMode() {
        
        navigationItem.title = "Reservation"
        
        for info in [reservation] {
            
            guard let hotel = info?.hotel,
                let firstName = info?.firstName,
                let lastName = info?.lastName,
                let voucherNumber = info?.voucherNumber,
                let tourRep = info?.tourRep,
                let tourCompany = info?.tourCompany,
                let previousDate = info?.date,
                let package = info?.package,
                let time = info?.time,
                let pax = info?.pax else { return }
            
            let reservedPackage = convertPackageResult(from: package)
            
            previousReservationDate = previousDate
            savedReservationDate = "\(previousDate) at \(time)"
            addReservationView.reservationDateTextfield.text = "\(previousDate) at \(time)"
            addReservationView.paxStepper.value = Double(pax)
            addReservationView.hotelNameTextField.text = hotel
            addReservationView.firstNameTextField.text = firstName
            addReservationView.lastNameTextField.text = lastName
            addReservationView.vourcherTextfield.text = voucherNumber
            addReservationView.tourRepTextfield.text = tourRep
            addReservationView.tourCompanyTextfield.text = tourCompany
            addReservationView.segmentedContol.selectedSegmentIndex = reservedPackage
            addReservationView.stepperValueLabel.text = "\((Int(addReservationView.paxStepper.value )))"
        }
    }
}
