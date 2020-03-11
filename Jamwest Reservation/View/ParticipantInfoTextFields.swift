//
//  ParticipantInfoTextFields.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ParticipantInfoTextFields: UITextField {

   
    let firstNameTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("First name", #imageLiteral(resourceName: "orangeName"))
        textfield.addTarget(self, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let lastNameTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Last name", #imageLiteral(resourceName: "orangeName"))
        textfield.addTarget(self, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let emailTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Email", #imageLiteral(resourceName: "orangeEmail "))
        textfield.keyboardType = .emailAddress
        textfield.addTarget(self, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let phoneNumberTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("(xxx) - xxx - xxxx", #imageLiteral(resourceName: "orangePhone "))
        textfield.keyboardType = .phonePad
        textfield.addTarget(self, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let dateTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon(nil, #imageLiteral(resourceName: "orangeDate"))
        textfield.isEnabled = false
        textfield.addTarget(self, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let countryTextfield: UITextField = {
        let textfield = UITextField()
        textfield.design(placeHolder: "Country", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 235, height: 51)
        textfield.setTextfieldIcon(#imageLiteral(resourceName: "orangeCountry "))
        textfield.layer.borderWidth = 0.85
        textfield.layer.cornerRadius = 4
        textfield.layer.masksToBounds = true
        textfield.layer.borderColor = Constants.Design.Color.Border.Blue
        textfield.allowsEditingTextAttributes = false
        textfield.textAlignment = .center
        textfield.addTarget(self, action: #selector(ParticipantInfoVC.handlePickerView), for: .editingDidBegin)
        return textfield
    }()
    
    let groupCountTextfield: UITextField = {
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
        textfield.addTarget(self, action: #selector(ParticipantInfoVC.handlePickerView), for: .editingDidBegin)
        return textfield
    }()
    

}
