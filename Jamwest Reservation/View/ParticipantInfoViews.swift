//
//  ParticipantInfoViews.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/11/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ParticipantInfoViews: UIView {
    
   weak var participantInfoDelegate: ParticipantInfoViewsDelegate?
    
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        configureConstraints()
        pickerViewContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - UIView
    let questionView: UIView = {
       
        let view = UIView()
        
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.25
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowRadius = 2.75
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
//    MARK: - Picker
    
    let pickerView: UIPickerView = {
       
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.setValue(UIColor.black, forKey: "textColor")
        return picker
    }()

    let popoverView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let popoverViewController: UIViewController = {
        
        let vc = UIViewController()
        return vc
    }()
    
//    MARK: - Buttons
    
    let toolBar: UIToolbar = {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolBar.barStyle = UIBarStyle.default
        
        toolBar.barTintColor = .lightGray
        toolBar.tintColor = Constants.Design.Color.Primary.HeavyGreen
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }()
    
    let space: UIBarButtonItem = {
       
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        return space
    }()
    
    lazy var doneButton: UIBarButtonItem = {
     
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneTapped(sender:)))
        return button
    }()
    
    lazy var yesAgeButton: UIButton = {
            
            let button = UIButton(type: .system)
            button.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//            button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped(sender:)), for: .touchUpInside)
            return button
        }()
        
    lazy var noAgeButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped(sender:)), for: .touchUpInside)
            return button
        }()
    
    lazy var yesBackProblemButton: UIButton = {
            
            let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()
        
    lazy var noBackProblemButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()

    lazy var yesHeartProblemButton: UIButton = {
            
            let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()
        
    lazy var noHeartProblemButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()
    
    lazy var yesUnderInfluenceButton: UIButton = {
            
            let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()
        
    lazy var noUnderInfluenceButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                    button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()
    
    lazy var yesPregnantButton: UIButton = {
            
            let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()
        
    lazy var noPregnantButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
//                button.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .touchUpInside)
            return button
        }()
    
    
//    MARK: - Textfields
    lazy var firstNameTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("First name", #imageLiteral(resourceName: "orangeName"))
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    lazy var lastNameTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Last name", #imageLiteral(resourceName: "orangeName"))
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    lazy var emailTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Email", #imageLiteral(resourceName: "orangeEmail "))
        textfield.keyboardType = .emailAddress
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    lazy var phoneNumberTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("(xxx) - xxx - xxxx", #imageLiteral(resourceName: "orangePhone "))
        textfield.keyboardType = .phonePad
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    lazy var dateTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon(nil, #imageLiteral(resourceName: "orangeDate"))
        textfield.isEnabled = false
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    lazy var countryTextfield: UITextField = {
        let textfield = UITextField()
        textfield.design(placeHolder: "Country", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 235, height: 51)
        textfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeCountry "))
        textfield.layer.borderWidth = 0.85
        textfield.layer.cornerRadius = 4
        textfield.layer.masksToBounds = true
        textfield.layer.borderColor = Constants.Design.Color.Border.Blue
        textfield.allowsEditingTextAttributes = false
        textfield.textAlignment = .center
        textfield.addTarget(self, action: #selector(handlePickerViewTextFieldTapped(textfield:)), for: .editingDidBegin)
        return textfield
    }()
    
    lazy var groupCountTextfield: UITextField = {
        let textfield = UITextField()
        textfield.design(placeHolder: nil, backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 140, height: 51)
        textfield.text = "1"
        textfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeGroup"))
        textfield.allowsEditingTextAttributes = false
        textfield.textAlignment = .center
        textfield.layer.borderWidth = 0.85
        textfield.layer.cornerRadius = 4
        textfield.layer.masksToBounds = true
        textfield.layer.borderColor = Constants.Design.Color.Border.Blue
        textfield.addTarget(self, action: #selector(handlePickerViewTextFieldTapped(textfield:)), for: .editingDidBegin)
        return textfield
    }()
    
//    MARK: - Labels
    let firstNameLabel: UILabel = {

         let label = UILabel()
         label.labelConfigurations(text: " First name", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
         return label
        }()

        let lastNameLabel: UILabel = {

         let label = UILabel()
         label.labelConfigurations(text: " Last name", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
         return label
        }()
        
        let emailLabel: UILabel = {

         let label = UILabel()
         label.labelConfigurations(text: " Email", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
         return label
        }()
        
        let countryLabel: UILabel = {

         let label = UILabel()
         label.labelConfigurations(text: " Country of residence", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
         return label
        }()
        
        let phoneNumberLabel: UILabel = {

         let label = UILabel()
         label.labelConfigurations(text: " Phone number", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
         return label
        }()
        
        let dateLabel: UILabel = {
            
         let label = UILabel()
         label.labelConfigurations(text: " Date", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
         return label
        }()
        
        let groupCountLabel: UILabel = {
            
         let label = UILabel()
         label.labelConfigurations(text: " Group Count", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
         return label
        }()
        
    //    MARK: - Question labels
        
        let questionaireLabel: UILabel = {

         let label = UILabel()
         let attributedTitle = NSMutableAttributedString(string: "Answer the following questions accurately", attributes: [NSAttributedString.Key.font : UIFont(name: helveticaNeue_Bold, size: 24) ?? UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.foregroundColor: UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
            
         label.attributedText = attributedTitle
         label.textColor = Constants.Design.Color.Primary.MarkerColor
         label.layer.shadowColor = UIColor.gray.cgColor
         label.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
         label.layer.shadowRadius = 0.25
         label.layer.shadowOpacity = 0.50
         return label
        }()
        
        let ageLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Are you over 18 years of age?", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 20)
            return label
        }()
        
        let heartProblemLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Do you have heart problems?", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 20)
            return label
        }()
        
        let backProblemLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Do you have back problems?", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 20)
            return label
        }()
        
        let underInfluenceLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Are you under the influence of (drug/alcohol)?", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 20)
            return label
        }()
        
        let pregnantLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Are you pregnant?", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 20)
            return label
        }()
        
    //    MARK: - Answers labels
        
        let ageYesAnswerLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Yes", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let ageNoAnswerLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "No", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let backProblemYesAnswersLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Yes", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let backProblemNoAnswersLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "No", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let heartProblemYesAnswersLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Yes", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let heartProblemNoAnswersLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "No", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let underInfluenceYesAnswerLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Yes", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let underInfluenceNoAnswerLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "No", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let pregnantYesAnswersLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "Yes", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
        
        let pregnantNoAnswersLabel: UILabel = {
            
            let label = UILabel()
            label.labelConfigurations(text: "No", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 17)
            return label
        }()
    
//    MARK: - Handlers
    
    @objc func handlePickerViewTextFieldTapped(textfield : UITextField) {
        participantInfoDelegate?.handlePresentPickerView(for: textfield)
    }
    
    @objc func handleDoneTapped(sender: UIButton) {
        participantInfoDelegate?.handlePickerViewDoneButton(for: sender)
    }
    
//    MARK: - Constraints
    
    func pickerViewContraints() {
        popoverView.addSubview(toolBar)
        popoverView.addSubview(pickerView)
        
    toolBar.anchor(top: popoverView.topAnchor, left: popoverView.leftAnchor, bottom: nil, right: popoverView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
    pickerView.anchor(top: toolBar.bottomAnchor, left: popoverView.leftAnchor, bottom: popoverView.bottomAnchor, right: popoverView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func configureConstraints() {
        
        let firstNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextfield])
        firstNameStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        firstNameStackView.axis = .vertical
        
        let lastNameStackView = UIStackView(arrangedSubviews: [lastNameLabel, lastNameTextfield])
        lastNameStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        lastNameStackView.axis = .vertical
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextfield])
        emailStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        emailStackView.axis = .vertical
        
        let phoneNumberStackView = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberTextfield])
        phoneNumberStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        phoneNumberStackView.axis = .vertical
        
        let dateStackView = UIStackView(arrangedSubviews: [dateLabel, dateTextfield])
        dateStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        dateStackView.axis = .vertical
        
        let countryStackView = UIStackView(arrangedSubviews: [countryLabel, countryTextfield])
        countryStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        countryStackView.axis = .vertical
        
        let groupCountStackView = UIStackView(arrangedSubviews: [groupCountLabel, groupCountTextfield])
        groupCountStackView.configureStackView(alignment: .center, distribution: .fillProportionally, spacing: nil)
        groupCountStackView.axis = .vertical
        
        let leftStackView = UIStackView(arrangedSubviews: [firstNameStackView, phoneNumberStackView, dateStackView])
        leftStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
        leftStackView.axis = .vertical
        
        let rightStackView = UIStackView(arrangedSubviews: [lastNameStackView, emailStackView])
        rightStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
        rightStackView.axis = .vertical
        
        let bottomRightStackView = UIStackView(arrangedSubviews: [countryStackView, groupCountStackView])
        bottomRightStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 25)
        bottomRightStackView.axis = .horizontal
        
//        MARK: - Age question constraints
        let ageYesStackView = UIStackView(arrangedSubviews: [yesAgeButton ,ageYesAnswerLabel])
        ageYesStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        ageYesStackView.axis = .horizontal
        
        let ageNoStackView = UIStackView(arrangedSubviews: [noAgeButton ,ageNoAnswerLabel])
        ageNoStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        ageNoStackView.axis = .horizontal
        
        let ageAnswersStackView = UIStackView(arrangedSubviews: [ageYesStackView, ageNoStackView])
        ageAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
        ageAnswersStackView.axis = .horizontal
        
        let ageStackView = UIStackView(arrangedSubviews: [ageLabel, ageAnswersStackView])
        ageStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
        ageStackView.axis = .vertical
        
//        MARK: - Back problem question constraints
        let yesBackProblemStackView = UIStackView(arrangedSubviews: [yesBackProblemButton ,backProblemYesAnswersLabel])
       yesBackProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
       yesBackProblemStackView.axis = .horizontal

       let noBackProblemStackView = UIStackView(arrangedSubviews: [noBackProblemButton ,backProblemNoAnswersLabel])
       noBackProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
       noBackProblemStackView.axis = .horizontal

       let backProblemAnswersStackView = UIStackView(arrangedSubviews: [yesBackProblemStackView, noBackProblemStackView])
       backProblemAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
       backProblemAnswersStackView.axis = .horizontal

       let backProblemStackView = UIStackView(arrangedSubviews: [backProblemLabel, backProblemAnswersStackView])
       backProblemStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
       backProblemStackView.axis = .vertical
        
//        MARK: - Heart problem question constraints
        let yesHeartProblemStackView = UIStackView(arrangedSubviews: [yesHeartProblemButton ,heartProblemYesAnswersLabel])
        yesHeartProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        yesHeartProblemStackView.axis = .horizontal
        
        let noHeartProblemStackView = UIStackView(arrangedSubviews: [noHeartProblemButton ,heartProblemNoAnswersLabel])
        noHeartProblemStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        noHeartProblemStackView.axis = .horizontal
        
        let heartProblemAnswersStackView = UIStackView(arrangedSubviews: [yesHeartProblemStackView, noHeartProblemStackView])
        heartProblemAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
        heartProblemAnswersStackView.axis = .horizontal
        
        let heartProblemStackView = UIStackView(arrangedSubviews: [heartProblemLabel, heartProblemAnswersStackView])
        heartProblemStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
        heartProblemStackView.axis = .vertical
        
//        MARK: - Under influence question constraints
        let yesUnderInfluenceStackView = UIStackView(arrangedSubviews: [yesUnderInfluenceButton ,underInfluenceYesAnswerLabel])
        yesUnderInfluenceStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        yesUnderInfluenceStackView.axis = .horizontal
        
        let noUnderInfluenceStackView = UIStackView(arrangedSubviews: [noUnderInfluenceButton ,underInfluenceNoAnswerLabel])
        noUnderInfluenceStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        noUnderInfluenceStackView.axis = .horizontal
        
        let underInfluenceAnswersStackView = UIStackView(arrangedSubviews: [yesUnderInfluenceStackView, noUnderInfluenceStackView])
        underInfluenceAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
        underInfluenceAnswersStackView.axis = .horizontal
        
        let underInfluenceStackView = UIStackView(arrangedSubviews: [underInfluenceLabel, underInfluenceAnswersStackView])
        underInfluenceStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
        underInfluenceStackView.axis = .vertical

//        MARK: - Pregnant question constraints
        let yesPregnantStackView = UIStackView(arrangedSubviews: [yesPregnantButton ,pregnantYesAnswersLabel])
        yesPregnantStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        yesPregnantStackView.axis = .horizontal
        
        let noPregnantStackView = UIStackView(arrangedSubviews: [noPregnantButton ,pregnantNoAnswersLabel])
        noPregnantStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 0)
        noPregnantStackView.axis = .horizontal
        
        let pregnantAnswersStackView = UIStackView(arrangedSubviews: [yesPregnantStackView, noPregnantStackView])
        pregnantAnswersStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
        pregnantAnswersStackView.axis = .horizontal
        
        let pregnantStackView = UIStackView(arrangedSubviews: [pregnantLabel, pregnantAnswersStackView])
        pregnantStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 6)
        pregnantStackView.axis = .vertical
        
        
//        MARK: - Anchors
        addSubview(leftStackView)
        leftStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 80, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(rightStackView)
        rightStackView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 0, height: 0)
        
        addSubview(bottomRightStackView)
        bottomRightStackView.anchor(top: rightStackView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 0, height: 0)
        
        addSubview(questionView)
        questionView.anchor(top: bottomRightStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 80, paddingBottom: 25, paddingRight: 80, width: 0, height: 0)
        
        questionView.addSubview(questionaireLabel)
        questionaireLabel.anchor(top: questionView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        questionaireLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor).isActive = true
        
        questionView.addSubview(pregnantStackView)
        pregnantStackView.anchor(top: questionaireLabel.bottomAnchor, left: questionView.leftAnchor, bottom: nil, right: nil, paddingTop: 35, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
        questionView.addSubview(ageStackView)
        ageStackView.anchor(top: pregnantStackView.bottomAnchor, left: questionView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        questionView.addSubview(underInfluenceStackView)
        underInfluenceStackView.anchor(top: ageStackView.bottomAnchor, left: questionView.leftAnchor, bottom: questionView.bottomAnchor, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
        
        questionView.addSubview(backProblemStackView)
        backProblemStackView.anchor(top: nil, left: nil, bottom: nil, right: questionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        backProblemStackView.centerYAnchor.constraint(equalTo: pregnantStackView.centerYAnchor).isActive = true
        
        questionView.addSubview(heartProblemStackView)
        heartProblemStackView.anchor(top: nil, left: nil, bottom: nil, right: questionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 39, width: 0, height: 0)
        heartProblemStackView.centerYAnchor.constraint(equalTo: ageStackView.centerYAnchor).isActive = true

    }
    
                
    
}
