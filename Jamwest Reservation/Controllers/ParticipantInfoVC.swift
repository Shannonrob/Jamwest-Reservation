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
    
    
    override func loadView() {

        let newView = ParticipantInfoViews()
        newView.participantInfoDelegate = self
        view = newView
    }

    
//    MARK: - Handlers
    
    @objc func handleFormValidation() {
        
        print("tapped")
    }
    
    // present pickerview
    @objc func handlePickerView(textfield: UITextField) {
        
        pickerViewData = []
        var selectedTextfield: UITextField?
        
        switch textfield {
            
        case participantInfoView.countryTextfield:
            participantInfoView.countryTextfield.resignFirstResponder()
            selectedTextfield = participantInfoView.countryTextfield
            pickerViewDataLoop(textfield)
            countryTextfieldBool = true
            
        case participantInfoView.groupCountTextfield:
            participantInfoView.groupCountTextfield.resignFirstResponder()
            selectedTextfield = participantInfoView.groupCountTextfield
            pickerViewDataLoop(textfield)
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
        participantInfoView.pickerView.selectRow(0, inComponent: 0, animated: true)
        dismiss(animated: true, completion: nil)
    }

//    MARK: - Protocols
    
    func handlePresentPickerView(for view: AnyObject) {
        if view as! NSObject == participantInfoView.yesAgeButton {
            print("age button")
        } else {
        print("handle Picker view tapped")
        }
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
    
    
    func configureConstraints() {
        
//        let firstNameStackView = UIStackView(arrangedSubviews: [participantInfoView.firstNameLabel, participantInfoView.firstNameTextfield])
//        firstNameStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
//        firstNameStackView.axis = .vertical
//        
//        let lastNameStackView = UIStackView(arrangedSubviews: [participantInfoView.lastNameLabel, participantInfoView.lastNameTextfield])
//        lastNameStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
//        lastNameStackView.axis = .vertical
//        
//        let emailStackView = UIStackView(arrangedSubviews: [participantInfoView.emailLabel, participantInfoView.emailTextfield])
//        emailStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
//        emailStackView.axis = .vertical
//        
//        let phoneNumberStackView = UIStackView(arrangedSubviews: [participantInfoView.phoneNumberLabel, participantInfoView.phoneNumberTextfield])
//        phoneNumberStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
//        phoneNumberStackView.axis = .vertical
//        
//        let dateStackView = UIStackView(arrangedSubviews: [participantInfoView.dateLabel, participantInfoView.dateTextfield])
//        dateStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
//        dateStackView.axis = .vertical
//        
//        let countryStackView = UIStackView(arrangedSubviews: [participantInfoView.countryLabel, participantInfoView.countryTextfield])
//        countryStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
//        countryStackView.axis = .vertical
//        
//        let groupCountStackView = UIStackView(arrangedSubviews: [participantInfoView.groupCountLabel, participantInfoView.groupCountTextfield])
//        groupCountStackView.configureStackView(alignment: .center, distribution: .fillProportionally, spacing: nil)
//        groupCountStackView.axis = .vertical
//        
//        let leftStackView = UIStackView(arrangedSubviews: [firstNameStackView, phoneNumberStackView, dateStackView])
//        leftStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
//        leftStackView.axis = .vertical
//        
//        let rightStackView = UIStackView(arrangedSubviews: [lastNameStackView, emailStackView])
//        rightStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
//        rightStackView.axis = .vertical
//        
//        let bottomRightStackView = UIStackView(arrangedSubviews: [countryStackView, groupCountStackView])
//        bottomRightStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 25)
//        bottomRightStackView.axis = .horizontal
//        
////        MARK: - Age question constraints
//        let ageYesStackView = UIStackView(arrangedSubviews: [participantInfoView.yesAgeButton ,participantInfoView.ageYesAnswerLabel])
//        ageYesStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        ageYesStackView.axis = .horizontal
//        
//        let ageNoStackView = UIStackView(arrangedSubviews: [participantInfoView.noAgeButton ,participantInfoView.ageNoAnswerLabel])
//        ageNoStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        ageNoStackView.axis = .horizontal
//        
//        let ageAnswersStackView = UIStackView(arrangedSubviews: [ageYesStackView, ageNoStackView])
//        ageAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
//        ageAnswersStackView.axis = .horizontal
//        
//        let ageStackView = UIStackView(arrangedSubviews: [participantInfoView.ageLabel, ageAnswersStackView])
//        ageStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
//        ageStackView.axis = .vertical
//        
////        MARK: - Back problem question constraints
//        let yesBackProblemStackView = UIStackView(arrangedSubviews: [participantInfoView.yesBackProblemButton ,participantInfoView.backProblemYesAnswersLabel])
//       yesBackProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//       yesBackProblemStackView.axis = .horizontal
//
//       let noBackProblemStackView = UIStackView(arrangedSubviews: [participantInfoView.noBackProblemButton ,participantInfoView.backProblemNoAnswersLabel])
//       noBackProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//       noBackProblemStackView.axis = .horizontal
//
//       let backProblemAnswersStackView = UIStackView(arrangedSubviews: [yesBackProblemStackView, noBackProblemStackView])
//       backProblemAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
//       backProblemAnswersStackView.axis = .horizontal
//
//       let backProblemStackView = UIStackView(arrangedSubviews: [participantInfoView.backProblemLabel, backProblemAnswersStackView])
//       backProblemStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
//       backProblemStackView.axis = .vertical
//        
////        MARK: - Heart problem question constraints
//        let yesHeartProblemStackView = UIStackView(arrangedSubviews: [participantInfoView.yesHeartProblemButton ,participantInfoView.heartProblemYesAnswersLabel])
//        yesHeartProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        yesHeartProblemStackView.axis = .horizontal
//        
//        let noHeartProblemStackView = UIStackView(arrangedSubviews: [participantInfoView.noHeartProblemButton ,participantInfoView.heartProblemNoAnswersLabel])
//        noHeartProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        noHeartProblemStackView.axis = .horizontal
//        
//        let heartProblemAnswersStackView = UIStackView(arrangedSubviews: [yesHeartProblemStackView, noHeartProblemStackView])
//        heartProblemAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
//        heartProblemAnswersStackView.axis = .horizontal
//        
//        let heartProblemStackView = UIStackView(arrangedSubviews: [participantInfoView.heartProblemLabel, heartProblemAnswersStackView])
//        heartProblemStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
//        heartProblemStackView.axis = .vertical
//        
////        MARK: - Under influence question constraints
//        let yesUnderInfluenceStackView = UIStackView(arrangedSubviews: [participantInfoView.yesUnderInfluenceButton ,participantInfoView.underInfluenceYesAnswerLabel])
//        yesUnderInfluenceStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        yesUnderInfluenceStackView.axis = .horizontal
//        
//        let noUnderInfluenceStackView = UIStackView(arrangedSubviews: [participantInfoView.noUnderInfluenceButton ,participantInfoView.underInfluenceNoAnswerLabel])
//        noUnderInfluenceStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        noUnderInfluenceStackView.axis = .horizontal
//        
//        let underInfluenceAnswersStackView = UIStackView(arrangedSubviews: [yesUnderInfluenceStackView, noUnderInfluenceStackView])
//        underInfluenceAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
//        underInfluenceAnswersStackView.axis = .horizontal
//        
//        let underInfluenceStackView = UIStackView(arrangedSubviews: [participantInfoView.underInfluenceLabel, underInfluenceAnswersStackView])
//        underInfluenceStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
//        underInfluenceStackView.axis = .vertical
//
////        MARK: - Pregnant question constraints
//        let yesPregnantStackView = UIStackView(arrangedSubviews: [participantInfoView.yesPregnantButton ,participantInfoView.pregnantYesAnswersLabel])
//        yesPregnantStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        yesPregnantStackView.axis = .horizontal
//        
//        let noPregnantStackView = UIStackView(arrangedSubviews: [participantInfoView.noPregnantButton ,participantInfoView.pregnantNoAnswersLabel])
//        noPregnantStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
//        noPregnantStackView.axis = .horizontal
//        
//        let pregnantAnswersStackView = UIStackView(arrangedSubviews: [yesPregnantStackView, noPregnantStackView])
//        pregnantAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
//        pregnantAnswersStackView.axis = .horizontal
//        
//        let pregnantStackView = UIStackView(arrangedSubviews: [participantInfoView.pregnantLabel, pregnantAnswersStackView])
//        pregnantStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
//        pregnantStackView.axis = .vertical
//        
//        
////        MARK: - Anchors
//        view.addSubview(leftStackView)
//        leftStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 80, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        
//        view.addSubview(rightStackView)
//        rightStackView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 0, height: 0)
//        
//        view.addSubview(bottomRightStackView)
//        bottomRightStackView.anchor(top: rightStackView.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 0, height: 0)
//        
//        view.addSubview(questionView)
//        questionView.anchor(top: bottomRightStackView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 80, paddingBottom: 25, paddingRight: 80, width: 0, height: 0)
//        
//        questionView.addSubview(participantInfoView.questionaireLabel)
//        participantInfoView.questionaireLabel.anchor(top: questionView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        participantInfoView.questionaireLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor).isActive = true
//        
//        questionView.addSubview(pregnantStackView)
//        pregnantStackView.anchor(top: participantInfoView.questionaireLabel.bottomAnchor, left: questionView.leftAnchor, bottom: nil, right: nil, paddingTop: 35, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
//        
//        questionView.addSubview(ageStackView)
//        ageStackView.anchor(top: pregnantStackView.bottomAnchor, left: questionView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        
//        questionView.addSubview(underInfluenceStackView)
//        underInfluenceStackView.anchor(top: ageStackView.bottomAnchor, left: questionView.leftAnchor, bottom: questionView.bottomAnchor, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
//        
//        questionView.addSubview(backProblemStackView)
//        backProblemStackView.anchor(top: nil, left: nil, bottom: nil, right: questionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
//        backProblemStackView.centerYAnchor.constraint(equalTo: pregnantStackView.centerYAnchor).isActive = true
//        
//        questionView.addSubview(heartProblemStackView)
//        heartProblemStackView.anchor(top: nil, left: nil, bottom: nil, right: questionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 39, width: 0, height: 0)
//        heartProblemStackView.centerYAnchor.constraint(equalTo: ageStackView.centerYAnchor).isActive = true
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
