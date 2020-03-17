//
//  ParticipantInfoVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ParticipantInfoVC: UIViewController, UITextFieldDelegate, ParticipantInfoViewsDelegate {
    
//    MARK: - Properties
    
    var countryTextfieldBool = Bool()
    var pickerViewData = [PickerViewData]()
    var reservation: Reservation?
    var groupCounter = [Int]()
    var pickerViewSelection: String?
    var participantInfoView = ParticipantInfoViews()
    
//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    
        participantInfoView.firstNameTextfield.becomeFirstResponder()
        
        getCurrentDate(textField: participantInfoView.dateTextfield)
        
        textFieldDelegates()
        
        participantInfoView.pickerView.delegate = self
        participantInfoView.pickerView.dataSource = self
     
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // show custom UIView and comform to protocol
    override func loadView() {
        
        participantInfoView.participantInfoDelegate = self
        view = participantInfoView
    }

    
//    MARK: - Handlers
    
    @objc func handleFormValidation() {
        
        print("tapped")
    }
    
    @objc func handlePickerViewSelection() {

    // add form validation here for checking if group count textfield has text
        
        switch countryTextfieldBool {
            
        case true:
            
            if pickerViewSelection == nil && !participantInfoView.countryTextfield.text!.isEmpty {
                pickerViewSelection = participantInfoView.countryTextfield.text
            }
            participantInfoView.countryTextfield.text = pickerViewSelection
             pickerViewSelection = nil
            
        case false:
            
            if pickerViewSelection == nil && !participantInfoView.groupCountTextfield.text!.isEmpty {
                pickerViewSelection = participantInfoView.groupCountTextfield.text
            }
            participantInfoView.groupCountTextfield.text = pickerViewSelection
            pickerViewSelection = nil
        }
        
        dismiss(animated: true) {
            self.participantInfoView.pickerView.selectRow(0, inComponent: 0, animated: true)
        }
    }

//    MARK: - Protocols
    
    // present picker view
    func handlePresentPickerView(for textfield: NSObject) {
        
        pickerViewData = []
       var selectedTextfield: UITextField?
       
       switch textfield {
           
       case participantInfoView.countryTextfield:
           participantInfoView.countryTextfield.resignFirstResponder()
           selectedTextfield = participantInfoView.countryTextfield
           pickerViewDataLoop(textfield as! UITextField)
           countryTextfieldBool = true
           
       case participantInfoView.groupCountTextfield:
           participantInfoView.groupCountTextfield.resignFirstResponder()
           selectedTextfield = participantInfoView.groupCountTextfield
           pickerViewDataLoop(textfield as! UITextField)
           countryTextfieldBool = false
           
       default:
           break
       }
       
       let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
       toolBar.barStyle = UIBarStyle.default
       let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handlePickerViewSelection))
       toolBar.barTintColor = .lightGray
       toolBar.tintColor = Constants.Design.Color.Primary.HeavyGreen
       toolBar.setItems([space, doneButton], animated: false)
       toolBar.isUserInteractionEnabled = true
       toolBar.sizeToFit()
       
       // the dimensions of the pickerview size
       let groupCountPickerSize = CGSize(width: (selectedTextfield!.frame.width) - 20, height: 200)
       let popoverView = UIView()
       popoverView.backgroundColor = .white
       let popoverViewController = UIViewController()
   
       popoverView.addSubview(toolBar)
       popoverView.addSubview(participantInfoView.pickerView)

       popoverViewController.view = popoverView
       popoverViewController.modalPresentationStyle = .popover
       popoverViewController.view.frame = CGRect(x: 0, y: 0, width: groupCountPickerSize.width, height: groupCountPickerSize.height)
       popoverViewController.preferredContentSize = groupCountPickerSize
       popoverViewController.popoverPresentationController?.sourceView = selectedTextfield
       popoverViewController.popoverPresentationController?.permittedArrowDirections = .up
       popoverViewController.popoverPresentationController?.sourceRect = CGRect(x: (selectedTextfield!.bounds.width) / 2, y: selectedTextfield!.bounds.height + 1, width: 0, height: 0)
       popoverViewController.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate

       toolBar.anchor(top: popoverView.topAnchor, left: popoverView.leftAnchor, bottom: nil, right: popoverView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
       participantInfoView.pickerView.anchor(top: toolBar.bottomAnchor, left: popoverView.leftAnchor, bottom: popoverView.bottomAnchor, right: popoverView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
       self.present(popoverViewController, animated: true, completion: nil)
    }
    
//    MARK: - Helpers Functions
    
    // loop and appends array to pickerview data model
    func pickerViewDataLoop(_ textfield: UITextField) {
        
        switch textfield {
            
        case participantInfoView.countryTextfield:
            for countries in countries {
                
                let countriesResult = PickerViewData(title: String(countries))
                pickerViewData.append(countriesResult)
            }
            
        case participantInfoView.groupCountTextfield:
            for numbers in 1...99 {
                
                let numbersResult = PickerViewData(title: String(numbers))
                pickerViewData.append(numbersResult)
            }
        default:
            break
        }
    }
    
    func textFieldDelegates() {
        
        participantInfoView.firstNameTextfield.delegate = self
        participantInfoView.lastNameTextfield.delegate = self
        participantInfoView.phoneNumberTextfield.delegate = self
        participantInfoView.emailTextfield.delegate = self
        participantInfoView.countryTextfield.delegate = self
        participantInfoView.dateTextfield.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
            
        case participantInfoView.firstNameTextfield:
            participantInfoView.lastNameTextfield.becomeFirstResponder()
        case participantInfoView.lastNameTextfield:
            participantInfoView.phoneNumberTextfield.becomeFirstResponder()
        case participantInfoView.phoneNumberTextfield:
            participantInfoView.emailTextfield.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           
        if participantInfoView.firstNameTextfield.isEditing ||
           participantInfoView.lastNameTextfield.isEditing ||
           participantInfoView.phoneNumberTextfield.isEditing ||
           participantInfoView.emailTextfield.isEditing ||
           participantInfoView.countryTextfield.isEditing {
            participantInfoView.countryTextfield.isEnabled = false
           participantInfoView.groupCountTextfield.isEnabled = false
           }
       }
       
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
        participantInfoView.countryTextfield.isEnabled = true
        participantInfoView.groupCountTextfield.isEnabled = true
        return true
    }
    
    func getCurrentDate(textField: UITextField) {
        
        var calendar: Calendar = Calendar.current
        let currentDate: Date = Date()
        var dateComponents: DateComponents = DateComponents()

        calendar.timeZone = TimeZone(identifier: "EST")!
        dateComponents.calendar = calendar
        
        let currentDateFormatter = DateFormatter()
        currentDateFormatter.dateStyle = .medium
        
        textField.text = currentDateFormatter.string(from: currentDate)
    }
    
    
    func configureUI() {
        
        view.backgroundColor = Constants.Design.Color.Background.FadeGray
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Participant information"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = Constants.Design.Color.Primary.HeavyGreen
        
        let navigationFont = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationFont]
    }
}

extension ParticipantInfoVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerViewData[row].title
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerViewSelection = String(pickerViewData[row].title)
    }
}
