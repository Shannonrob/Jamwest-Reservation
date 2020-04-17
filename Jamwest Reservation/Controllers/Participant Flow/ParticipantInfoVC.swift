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
    
//    var groupCounter = [Int]()
    var pickerViewSelection: String?
    
    var countryTextfieldBool = Bool()
    var pregnantAnswer = Bool()
    var underAgeAnswer = Bool()
    var underInfluenceAnswer = Bool()
    var backProblemsAnswer = Bool()
    var heartProblemsAnswer = Bool()
    var firstNameTextFieldFilled = Bool()
    var lastNameTextFieldFilled = Bool()
    var countryTextFieldFilled = Bool()
    var requiredTextFieldsFilled = Bool()
    var isUnderAge = Bool()
    
    var pregnantAnsweredValue = Int()
    var underAgeAnsweredValue = Int()
    var underInfluenceAnsweredValue = Int()
    var backProblemsAnsweredValue = Int()
    var heartProblemsAnsweredValue = Int()
    var questionsAnswered = Int()
    
    var participantInformation = [ParticipantInformation]()
    var waiverVC = WaiverVC()
    var pickerViewData = [PickerViewData]()
    var reservation: Reservation?
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        questionsAnswered = 0
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
        // configure pickerView to fit textfield dimensions
        
        participantInfoView.toolBar.setItems([participantInfoView.space, participantInfoView.doneButton], animated: false)
        
        // the dimensions of the pickerview size
        let groupCountPickerSize = CGSize(width: (selectedTextfield!.frame.width) - 20, height: 200)
        
        participantInfoView.popoverViewController.view = participantInfoView.popoverView
        participantInfoView.popoverViewController.modalPresentationStyle = .popover
        participantInfoView.popoverViewController.view.frame = CGRect(x: 0, y: 0, width: groupCountPickerSize.width, height: groupCountPickerSize.height)
        participantInfoView.popoverViewController.preferredContentSize = groupCountPickerSize
        participantInfoView.popoverViewController.popoverPresentationController?.sourceView = selectedTextfield
        participantInfoView.popoverViewController.popoverPresentationController?.permittedArrowDirections = .up
        participantInfoView.popoverViewController.popoverPresentationController?.sourceRect = CGRect(x: (selectedTextfield!.bounds.width) / 2, y: selectedTextfield!.bounds.height + 1, width: 0, height: 0)
        participantInfoView.popoverViewController.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
        
        self.present(participantInfoView.popoverViewController, animated: true, completion: nil)
    }
    
    // handle done button on pickerView toolBar
    func handlePickerViewDoneButton() {
        
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
        // check if textField is empty
       countryTextFieldFilled = textFieldValidation(with: participantInfoView.countryTextfield, label: participantInfoView.countryRequiredLabel)
    }
    
    func handleSelectedAnswers(for button: NSObject) {
        
        updateSelectedAnswer(sender: button as! UIButton)
        
        switch button {
            
        case participantInfoView.yesAgeButton:
            
            handleAnimate(is: true)
            isUnderAge = true
        
        case participantInfoView.noAgeButton:
            
            handleAnimate(is: false)
            isUnderAge = false
            participantInfoView.guardianRequiredLabel.isHidden = true
            
        default:
            break
        }
    }
    
    //    MARK: - Handlers
    
    @objc func handleNextButton() {
        
        updateQuestionsAnsweredValue()
        
        // check if textFields are empty
        firstNameTextFieldFilled = textFieldValidation(with: participantInfoView.firstNameTextfield, label: participantInfoView.firstNameRequiredLabel)
        lastNameTextFieldFilled = textFieldValidation(with: participantInfoView.lastNameTextfield, label: participantInfoView.lastNameRequiredLabel)
       countryTextFieldFilled = textFieldValidation(with: participantInfoView.countryTextfield, label: participantInfoView.countryRequiredLabel)
        
        
        // check if values are true
        updateRequiredTextFieldValue(with: firstNameTextFieldFilled, with: lastNameTextFieldFilled, with: countryTextFieldFilled)
        
        if questionsAnswered > 4 && requiredTextFieldsFilled {
            
            // check if textField has value
            if !participantInfoView.guardianTextField.isHidden && !participantInfoView.guardianTextField.hasText {
                
               _ = textFieldValidation(with: participantInfoView.guardianTextField, label: participantInfoView.guardianRequiredLabel)
                Alert.answersRequiredMessage(on: self, with: "Fill in required text fields!")
            
            } else {
                
                // pass data to WaiverVC
                passData()

                let waiverVC = WaiverVC()
                waiverVC.modalPresentationStyle = .fullScreen
                waiverVC.participantInformation = self.participantInformation
                waiverVC.reservation = self.reservation
                presentDetail(waiverVC)
            }

        } else if !requiredTextFieldsFilled {

            Alert.showHasTextMessage(on: self, with: "Fill in required text fields!")

        } else {

            Alert.answersRequiredMessage(on: self, with: "You must answer all questions to proceed!!!")
        }

        questionsAnswered = 0
    }
    
    //    MARK: - Helpers Functions
    
    // updates selected/unselected button icons
    func updateSelectedAnswer(sender tapped: UIButton) {
        
        switch tapped {
        case participantInfoView.yesPregnantButton:
            pregnantAnswer = true
            participantInfoView.yesPregnantButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            participantInfoView.noPregnantButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            
        case participantInfoView.noPregnantButton:
            pregnantAnswer = false
            participantInfoView.yesPregnantButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            participantInfoView.noPregnantButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            
        case participantInfoView.yesAgeButton:
            underAgeAnswer = true
            participantInfoView.yesAgeButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            participantInfoView.noAgeButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            
        case participantInfoView.noAgeButton:
            underAgeAnswer = false
            participantInfoView.yesAgeButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            participantInfoView.noAgeButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            
        case participantInfoView.yesUnderInfluenceButton:
            underInfluenceAnswer = true
            participantInfoView.yesUnderInfluenceButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            participantInfoView.noUnderInfluenceButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            
        case participantInfoView.noUnderInfluenceButton:
            underInfluenceAnswer = false
            participantInfoView.yesUnderInfluenceButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            participantInfoView.noUnderInfluenceButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            
        case participantInfoView.yesBackProblemButton:
            backProblemsAnswer = true
            participantInfoView.yesBackProblemButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            participantInfoView.noBackProblemButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            
        case participantInfoView.noBackProblemButton:
            backProblemsAnswer = false
            participantInfoView.yesBackProblemButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            participantInfoView.noBackProblemButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            
        case participantInfoView.yesHeartProblemButton:
            heartProblemsAnswer = true
            participantInfoView.yesHeartProblemButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            participantInfoView.noHeartProblemButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            
        case participantInfoView.noHeartProblemButton:
            heartProblemsAnswer = false
            participantInfoView.yesHeartProblemButton.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            participantInfoView.noHeartProblemButton.selectedPackageButtonState(icon: "green_radio_Selected", font: nil, enabled: false)
            
        default:
            break
        }
        answeredQuestionsValidation(with: tapped)
    }
    
    // check if buttons are selected
    func answeredQuestionsValidation(with button: UIButton) {
        
        if !participantInfoView.yesPregnantButton.isEnabled ||
            !participantInfoView.noPregnantButton.isEnabled {
           pregnantAnsweredValue = 1
        }
        if !participantInfoView.yesAgeButton.isEnabled ||
            !participantInfoView.noAgeButton.isEnabled {
            underAgeAnsweredValue = 1
        }
        if !participantInfoView.yesUnderInfluenceButton.isEnabled ||
            !participantInfoView.noUnderInfluenceButton.isEnabled {
            underInfluenceAnsweredValue = 1
        }
        if !participantInfoView.yesBackProblemButton.isEnabled ||
            !participantInfoView.noBackProblemButton.isEnabled {
            backProblemsAnsweredValue = 1
        }
        if !participantInfoView.yesHeartProblemButton.isEnabled ||
            !participantInfoView.noHeartProblemButton.isEnabled {
            heartProblemsAnsweredValue = 1
        }
    }
    
    //updates the value of questionsAnswered
    func updateQuestionsAnsweredValue() {
        
        questionsAnswered += pregnantAnsweredValue
        questionsAnswered += underAgeAnsweredValue
        questionsAnswered += underInfluenceAnsweredValue
        questionsAnswered += backProblemsAnsweredValue
        questionsAnswered += heartProblemsAnsweredValue
    }
    
    // check if textField is empty
    func textFieldValidation(with textField: UITextField, label: UILabel) -> Bool {
        
        if !textField.hasText {
            label.isHidden = false
            return false
        } else {
            label.isHidden = true
            return true
        }
    }
    
    // presents or hides guardianTextField based on answer tapped
    func handleAnimate(is condition: Bool) {
        
        if condition {
            
            participantInfoView.guardianTextField.isHidden = false
            
        } else {
            
            participantInfoView.guardianTextField.isHidden = true
            participantInfoView.guardianTextField.text = nil
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    // update the boolean value if all labels are hidden
    func updateRequiredTextFieldValue(with first: Bool, with second: Bool, with third: Bool) {
        
        if first && second && third {
            requiredTextFieldsFilled = true
        } else {
            requiredTextFieldsFilled = false
        }
    }
    
    // collects participant information
    func passData() {
        
        guard let firstName = participantInfoView.firstNameTextfield.text,
            let lastName = participantInfoView.lastNameTextfield.text,
            let phoneNumber = participantInfoView.phoneNumberTextfield.text,
            let email = participantInfoView.emailTextfield.text,
            let date = participantInfoView.dateTextfield.text,
            let country = participantInfoView.countryTextfield.text,
            let groupCount = participantInfoView.groupCountTextfield.text,
            let guardianName = participantInfoView.guardianTextField.text else { return }
        
        let pregnantAnswer = self.pregnantAnswer
        let underAgeAnswer = self.underAgeAnswer
        let underInfluenceAnswer = self.underInfluenceAnswer
        let backProblemsAnswer = self.backProblemsAnswer
        let heartProblemsAnswer = self.heartProblemsAnswer
        
        self.participantInformation = [ParticipantInformation(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, emailAddress: email, currentDate: date, country: country, groupCount: groupCount, guardianName: guardianName, pregnantAnswer: pregnantAnswer, ageAnswer: underAgeAnswer, underInfluenceAnswer: underInfluenceAnswer, backProblemAnswer: backProblemsAnswer, heartProblemAnswer: heartProblemsAnswer)]
    }
    
    // format textfield for phone number pattern
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
            
        case participantInfoView.phoneNumberTextfield:
            var fullString = textField.text ?? ""
            fullString.append(string)
            if range.length == 1 {
                textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: true)
            } else {
                textField.text = format(phoneNumber: fullString)
            }
            return false
        default:
            break
        }
        return true
    }
    
    // format textfield for phone number pattern
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)
            
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
        }
        
        return number
    }
    
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
    
    // set ParticipantVC as textFields delegate
    func textFieldDelegates() {
        
        participantInfoView.firstNameTextfield.delegate = self
        participantInfoView.lastNameTextfield.delegate = self
        participantInfoView.phoneNumberTextfield.delegate = self
        participantInfoView.emailTextfield.delegate = self
        participantInfoView.dateTextfield.delegate = self
        participantInfoView.guardianTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case participantInfoView.firstNameTextfield:
            participantInfoView.lastNameTextfield.becomeFirstResponder()
        case participantInfoView.lastNameTextfield:
            participantInfoView.phoneNumberTextfield.becomeFirstResponder()
        case participantInfoView.phoneNumberTextfield:
            participantInfoView.emailTextfield.becomeFirstResponder()
        case participantInfoView.guardianTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    // disable editing once certain textFields are editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if participantInfoView.firstNameTextfield.isEditing ||
            participantInfoView.lastNameTextfield.isEditing ||
            participantInfoView.phoneNumberTextfield.isEditing ||
            participantInfoView.emailTextfield.isEditing ||
            participantInfoView.guardianTextField.isEditing ||
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
    
    // check if textFields are empty after editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if isUnderAge {
            _ = textFieldValidation(with: participantInfoView.guardianTextField, label: participantInfoView.guardianRequiredLabel)
        }
        
       firstNameTextFieldFilled = textFieldValidation(with: participantInfoView.firstNameTextfield, label: participantInfoView.firstNameRequiredLabel)
       lastNameTextFieldFilled = textFieldValidation(with: participantInfoView.lastNameTextfield, label: participantInfoView.lastNameRequiredLabel)
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
        
        view.backgroundColor = Color.Background.fadeGray
        
        navigationItem.title = "Participant information"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = Color.Primary.heavyGreen
        
        let navigationFont = UIFont.boldSystemFont(ofSize: 25)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navigationFont]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(handleNextButton))
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
