//
//  AddReservationView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 5/26/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class AddReservationView: UIView {
    
    //    MARK: - Properties
    var delegate: AddReservationDelegate?
    
    let hotelNameTextField = AddReservationTextField(icon: #imageLiteral(resourceName: "orangeHotel"), placeholder: "Hotel")
    let tourRepTextfield = AddReservationTextField(icon: #imageLiteral(resourceName: "orangeRepresentative"), placeholder: "Representative")
    let groupNameTextfield = AddReservationTextField(icon: #imageLiteral(resourceName: "orangeName"), placeholder: "Name")
    let tourCompanyTextfield = AddReservationTextField(icon: #imageLiteral(resourceName: "orangeBus"), placeholder: "Tour Company")
    let vourcherTextfield = AddReservationTextField(icon: #imageLiteral(resourceName: "orangeNumber"), placeholder: "Voucher")
    let reservationDateTextfield = AddReservationTextField(icon: #imageLiteral(resourceName: "orangeDate"), placeholder: "mm/dd/yyyy")
    
    let hotelNameLabel = TextfieldHeaderLabel(text: " Hotel")
    let groupNameLabel = TextfieldHeaderLabel(text: " Group Name")
    let tourRepNameLabel = TextfieldHeaderLabel(text: " Tour Representative")
    let reservationDateLabel = TextfieldHeaderLabel(text: " Date")
    let voucherNumberLabel = TextfieldHeaderLabel(text: " Voucher #")
    let tourCompanyNameLabel = TextfieldHeaderLabel(text: " Tour Company")
    
    let selectPackageLabel = AddReservationLabel(text: "Reservation package :", textColor: .black,
                                                 font: Font.avenirNextDemibold, fontSize: 20)
    
    let paxQuantityLabel = AddReservationLabel(text: "Pax Quantity :", textColor: .black,
                                               font: Font.avenirNextDemibold, fontSize: 18)
    
    let stepperValueLabel = AddReservationLabel(text: "1", textColor: .black,
                                                font: Font.helveticaNeueBold, fontSize: 20)
    
    //    MARK: - UIStepper
    
    let paxStepper: UIStepper = {
        
        let stepper: UIStepper = UIStepper()
        stepper.tintColor = UIColor.white
        stepper.setIncrementImage(#imageLiteral(resourceName: "greenPlus").withRenderingMode(.alwaysOriginal), for: .normal)
        stepper.setDecrementImage(#imageLiteral(resourceName: "greenMinus ").withRenderingMode(.alwaysOriginal), for: .normal)
        stepper.minimumValue = 1
        stepper.maximumValue = 100
        stepper.value = 1
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(handleStepperTapped), for: UIControl.Event.valueChanged)
        return stepper
    }()
    
    let segmentedContol: UISegmentedControl = {
        
        let control = UISegmentedControl(items: ["Single Tour", "Combo Deal", "Super Deal", " Deluxe Package"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = Color.Hue.green
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)], for: .selected)
        control.addTarget(self, action: #selector(handleSegmentedControl), for: .valueChanged)
        return control
    }()
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        vourcherTextfield.keyboardType = .numberPad
        stepperValueLabel.shadowColor = Color.Primary.purple
        backgroundColor = Color.Background.fadeGray
        
        configureStackViewComponents()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Handlers
    
    @objc func handleTextFieldTapped(for sender: UITextField) {
        
        delegate?.handleFormValidation(for: self, with: sender)
    }
    
    @objc func handleShowDatePicker() {
        delegate?.handleShowDatePicker(for: self)
    }
    
    @objc func handleStepperTapped() {
        delegate?.handleStepperTapped(for: self)
    }
    
    @objc func handleSegmentedControl() {
        delegate?.handleSegmentControl(for: self)
    }
    
    //    MARK: - Helper Functions
    
    func addTargets() {
        
        hotelNameTextField.addTarget(self, action: #selector(handleTextFieldTapped(for:)), for: .editingChanged)
        groupNameTextfield.addTarget(self, action: #selector(handleTextFieldTapped(for:)), for: .editingChanged)
        tourRepTextfield.addTarget(self, action: #selector(handleTextFieldTapped(for:)), for: .editingChanged)
        vourcherTextfield.addTarget(self, action: #selector(handleTextFieldTapped(for:)), for: .editingChanged)
        tourCompanyTextfield.addTarget(self, action: #selector(handleTextFieldTapped(for:)), for: .editingChanged)
        reservationDateTextfield.addTarget(self, action: #selector(handleShowDatePicker), for: .editingDidBegin)
    }
    
    //    MARK: - Constraints
    
    func configureStackViewComponents(){
        
        let hotelStackView = UIStackView(arrangedSubviews: [hotelNameLabel, hotelNameTextField])
        hotelStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        hotelStackView.axis = .vertical
        
        let tourRepStackView = UIStackView(arrangedSubviews: [tourRepNameLabel, tourRepTextfield])
        tourRepStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        tourRepStackView.axis = .vertical
        
        let tourCompanyStackView = UIStackView(arrangedSubviews: [tourCompanyNameLabel, tourCompanyTextfield])
        tourCompanyStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        tourCompanyStackView.axis = .vertical
        
        let groupNameStackView = UIStackView(arrangedSubviews: [groupNameLabel, groupNameTextfield])
        groupNameStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        groupNameStackView.axis = .vertical
        
        let voucherNumberStackView = UIStackView(arrangedSubviews: [voucherNumberLabel, vourcherTextfield])
        voucherNumberStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        voucherNumberStackView.axis = .vertical
        
        let dateStackView = UIStackView(arrangedSubviews: [reservationDateLabel, reservationDateTextfield])
        dateStackView.configureStackView(alignment: .leading, distribution: .fillProportionally, spacing: nil)
        dateStackView.axis = .vertical
        
        let leftStackView = UIStackView(arrangedSubviews: [hotelStackView, groupNameStackView, tourRepStackView])
        leftStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
        leftStackView.axis = .vertical
        
        let rightStackView = UIStackView(arrangedSubviews: [dateStackView, voucherNumberStackView, tourCompanyStackView])
        rightStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 25)
        rightStackView.axis = .vertical
        
        let selectPackageStackView = UIStackView(arrangedSubviews: [selectPackageLabel, segmentedContol])
        selectPackageStackView.configureStackView(alignment: nil, distribution: .fillEqually, spacing: 0)
        selectPackageStackView.axis = .vertical
        
        let paxStackView = UIStackView(arrangedSubviews: [paxQuantityLabel, stepperValueLabel])
        paxStackView.configureStackView(alignment: .leading, distribution: .fillEqually, spacing: 15)
        
        // Stepper stackView
        let stepperStackView = UIStackView(arrangedSubviews: [paxStackView, paxStepper])
        stepperStackView.configureStackView(alignment: .leading, distribution: .equalSpacing, spacing: 10)
        stepperStackView.axis = .vertical
        
        addSubview(leftStackView)
        leftStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 30, paddingBottom: 0, paddingRight: 0, width: 300, height: 276)
        
        addSubview(rightStackView)
        rightStackView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 300, height: 276)
        
        addSubview(stepperStackView)
        stepperStackView.anchor(top: leftStackView.bottomAnchor, left: leftStackView.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(selectPackageStackView)
        selectPackageStackView.anchor(top: stepperStackView.bottomAnchor, left: leftStackView.leftAnchor, bottom: nil, right: rightStackView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 105)
    }
}
