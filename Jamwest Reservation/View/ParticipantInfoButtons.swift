//
//  ParticipantInfoButtons.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/7/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ParticipantInfoButtons: UIButton {


    let yesAgeButton: UIButton = {
        
        let button = UIButton(type: .system)
//        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
        button.unSelectedPackageButtonState(icon: "greenRadioSelected", font: nil, enabled: false)
//        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
        return button
    }()
    
    let noAgeButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
    
    let yesBackProblemButton: UIButton = {
            
            let button = UIButton(type: .system)
    //        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
            button.unSelectedPackageButtonState(icon: "greenRadioSelected", font: nil, enabled: false)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
        
    let noBackProblemButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()

    let yesHeartProblemButton: UIButton = {
            
            let button = UIButton(type: .system)
    //        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
            button.unSelectedPackageButtonState(icon: "greenRadioSelected", font: nil, enabled: false)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
        
    let noHeartProblemButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
    
    let yesUnderInfluenceButton: UIButton = {
            
            let button = UIButton(type: .system)
    //        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
            button.unSelectedPackageButtonState(icon: "greenRadioSelected", font: nil, enabled: false)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
        
        let noUnderInfluenceButton: UIButton = {
            
                let button = UIButton(type: .system)
            button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
        //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
                return button
            }()
    
    let yesPregnantButton: UIButton = {
            
            let button = UIButton(type: .system)
    //        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
            button.unSelectedPackageButtonState(icon: "greenRadioSelected", font: nil, enabled: false)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
        
    let noPregnantButton: UIButton = {
        
            let button = UIButton(type: .system)
        button.selectedPackageButtonState(icon: "greenRadioUnselected", font: nil, enabled: true)
    //        button.addTarget(self, action: #selector(<#handleSelectedTourPackage#>), for: .touchUpInside)
            return button
        }()
}
