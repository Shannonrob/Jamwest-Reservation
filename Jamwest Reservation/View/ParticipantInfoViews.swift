//
//  ParticipantInfoViews.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/11/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation
import UIKit

class ParticipantInfoViews {
    
    
//    MARK: - Buttons
    let yesAgeButton: UIButton = {
            
            let button = UIButton(type: .system)
            button.unSelectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
        
        let noAgeButton: UIButton = {
            
                let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
        
        let yesBackProblemButton: UIButton = {
                
                let button = UIButton(type: .system)
                button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
            
        let noBackProblemButton: UIButton = {
            
                let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()

        let yesHeartProblemButton: UIButton = {
                
                let button = UIButton(type: .system)
                button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
            
        let noHeartProblemButton: UIButton = {
            
                let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
        
        let yesUnderInfluenceButton: UIButton = {
                
                let button = UIButton(type: .system)
                button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
            
            let noUnderInfluenceButton: UIButton = {
                
                    let button = UIButton(type: .system)
                button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
            //        button.addTarget(self, action: #selector(handleSelectedTourPackage), for: .touchUpInside)
                    return button
                }()
        
        let yesPregnantButton: UIButton = {
                
                let button = UIButton(type: .system)
                button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
            
        let noPregnantButton: UIButton = {
            
                let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "green_radio_unselected_small", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
    
    
//    MARK: - Textfields
    let firstNameTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("First name", #imageLiteral(resourceName: "orangeName"))
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let lastNameTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Last name", #imageLiteral(resourceName: "orangeName"))
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let emailTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("Email", #imageLiteral(resourceName: "orangeEmail "))
        textfield.keyboardType = .emailAddress
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let phoneNumberTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon("(xxx) - xxx - xxxx", #imageLiteral(resourceName: "orangePhone "))
        textfield.keyboardType = .phonePad
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
        return textfield
    }()
    
    let dateTextfield: JamwestTextfieldClass = {
        let textfield = JamwestTextfieldClass()
        textfield.configurePlaceHolderWithIcon(nil, #imageLiteral(resourceName: "orangeDate"))
        textfield.isEnabled = false
        textfield.addTarget(textfield, action: #selector(ParticipantInfoVC.handleFormValidation), for: .editingChanged)
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
        textfield.addTarget(Selector.self, action: #selector(ParticipantInfoVC.handlePickerView(textfield:)), for: .editingDidBegin)
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
        textfield.addTarget(Selector.self, action: #selector(ParticipantInfoVC.handlePickerView(textfield:)), for: .editingDidBegin)
        return textfield
    }()
}
