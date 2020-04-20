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
    let questionView = JamwestDefaultView()
    
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
        toolBar.tintColor = Color.Primary.heavyGreen
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
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var noAgeButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var yesBackProblemButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var noBackProblemButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var yesHeartProblemButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var noHeartProblemButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var yesUnderInfluenceButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var noUnderInfluenceButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var yesPregnantButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var noPregnantButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        button.addTarget(self, action: #selector(answerButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    
    //    MARK: - Textfields
    let firstNameTextfield: JamwestTextfieldClass = {
        
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("First name", #imageLiteral(resourceName: "orangeName"))
        return textfield
    }()
    
    let lastNameTextfield: JamwestTextfieldClass = {
        
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Last name", #imageLiteral(resourceName: "orangeName"))
        return textfield
    }()
    
    let emailTextfield: JamwestTextfieldClass = {
        
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Email", #imageLiteral(resourceName: "orangeEmail "))
        textfield.keyboardType = .emailAddress
        return textfield
    }()
    
    let phoneNumberTextfield: JamwestTextfieldClass = {
        
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("(xxx) xxx - xxxx", #imageLiteral(resourceName: "orangePhone "))
        textfield.keyboardType = .phonePad
        return textfield
    }()
    
    let dateTextfield: ParticipantTextField = {

        let textfield = ParticipantTextField()
        textfield.configurePlaceHolderWithIcon(nil, #imageLiteral(resourceName: "orangeDate"))
        textfield.widthAnchor.constraint(equalToConstant: 170).isActive = true
        textfield.isEnabled = false
        return textfield
    }()
    
    lazy var countryTextfield: ParticipantTextField = {
        
        let textfield = ParticipantTextField()
        textfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeCountry "))
        textfield.allowsEditingTextAttributes = false
        textfield.textAlignment = .center
        textfield.attributedPlaceholder =  NSAttributedString(string: "Country",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.widthAnchor.constraint(equalToConstant: 220).isActive = true
        textfield.addTarget(self, action: #selector(handlePickerViewTextFieldTapped), for: .editingDidBegin)
        return textfield
    }()
    
    let guardianTextField: JamwestTextfieldClass = {
        
        let textfield = JamwestTextfieldClass()
        textfield.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textfield.placeholder = "Name"
        textfield.attributedPlaceholder =  NSAttributedString(string: "Name",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textfield
    }()

    //    MARK: - Labels
    
    let firstNameRequiredLabel = RequiredLabelClass()
    let lastNameRequiredLabel = RequiredLabelClass()
    let guardianRequiredLabel = RequiredLabelClass()
    
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
    
    let guardianLabel: UILabel = {
        
        let label = UILabel()
        let attributedTitle = NSMutableAttributedString(string: " Parent/Guardian", attributes: [NSAttributedString.Key.font : UIFont.init(name: Font.avenirNextDemibold, size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        attributedTitle.append(NSAttributedString(string: " (if under 18)", attributes: [NSAttributedString.Key.font : UIFont.init(name: Font.avenirNextMedium, size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        label.attributedText = attributedTitle
        return label
    }()
    
    //    MARK: - Question labels
    
    let questionaireLabel: UILabel = {
        
        let label = UILabel()
        let attributedTitle = NSMutableAttributedString(string: "Answer the following questions accurately", attributes: [NSAttributedString.Key.font : UIFont(name: Font.helveticaNeueBold, size: 24) ?? UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.foregroundColor: UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
        
        label.attributedText = attributedTitle
        label.textColor = Color.Primary.markerColor
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        label.layer.shadowRadius = 0.25
        label.layer.shadowOpacity = 0.50
        return label
    }()
    
    let ageLabel: UILabel = {
        
        let label = UILabel()
        label.labelConfigurations(text: "Are you under 18 years of age?", textColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), fontSize: 20)
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
    
    @objc func handlePickerViewTextFieldTapped() {
        participantInfoDelegate?.handlePresentPickerView()
    }
    
    @objc func handleDoneTapped(sender: UIButton) {
        participantInfoDelegate?.handlePickerViewDoneButton()
    }
    
    @objc func answerButtonTapped(sender: UIButton) {
        participantInfoDelegate?.handleSelectedAnswers(for: sender)
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
        
        let guardianStackView = UIStackView(arrangedSubviews: [guardianLabel, guardianTextField])
        guardianStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        guardianStackView.axis = .vertical
        
        let bottomLeftStackView = UIStackView(arrangedSubviews: [dateStackView, countryStackView])
        bottomLeftStackView.configureStackView(alignment: .center, distribution: .equalSpacing, spacing: 10)
            
        let leftStackView = UIStackView(arrangedSubviews: [firstNameStackView, phoneNumberStackView, bottomLeftStackView])
        leftStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
        leftStackView.axis = .vertical
        
        let rightStackView = UIStackView(arrangedSubviews: [lastNameStackView, emailStackView, guardianStackView])
        rightStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
        rightStackView.axis = .vertical
        
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
        
        addSubview(questionView)
        questionView.anchor(top: leftStackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 30, paddingLeft: 80, paddingBottom: 25, paddingRight: 80, width: 0, height: 0)
        
        questionView.addSubview(questionaireLabel)
        questionaireLabel.anchor(top: questionView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        questionaireLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor).isActive = true
        
        questionView.addSubview(pregnantStackView)
        pregnantStackView.anchor(top: questionaireLabel.bottomAnchor, left: questionView.leftAnchor, bottom: nil, right: nil, paddingTop: 35, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
        questionView.addSubview(ageStackView)
        ageStackView.anchor(top: pregnantStackView.bottomAnchor, left: questionView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        questionView.addSubview(underInfluenceStackView)
        underInfluenceStackView.anchor(top: ageStackView.bottomAnchor, left: questionView.leftAnchor, bottom: questionView.bottomAnchor, right: nil, paddingTop: 15, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        questionView.addSubview(backProblemStackView)
        backProblemStackView.anchor(top: nil, left: nil, bottom: nil, right: questionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        backProblemStackView.centerYAnchor.constraint(equalTo: pregnantStackView.centerYAnchor).isActive = true
        
        questionView.addSubview(heartProblemStackView)
        heartProblemStackView.anchor(top: nil, left: nil, bottom: nil, right: questionView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 39, width: 0, height: 0)
        heartProblemStackView.centerYAnchor.constraint(equalTo: ageStackView.centerYAnchor).isActive = true
     
        addSubview(firstNameRequiredLabel)
        firstNameRequiredLabel.anchor(top: firstNameTextfield.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 80, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(lastNameRequiredLabel)
        lastNameRequiredLabel.anchor(top: lastNameTextfield.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 402, width: 0, height: 0)
        
        addSubview(guardianRequiredLabel)
        guardianRequiredLabel.anchor(top: guardianTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        guardianRequiredLabel.leadingAnchor.constraint(equalTo: guardianTextField.leadingAnchor).isActive = true
    }
}
