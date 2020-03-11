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
}
