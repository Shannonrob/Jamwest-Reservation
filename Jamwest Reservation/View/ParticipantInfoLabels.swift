//
//  ParticipantInfoLabels.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ParticipantInfoLabels: UILabel {

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
    
    let questionaireLabel: UILabel = {

     let label = UILabel()
     let attributedTitle = NSMutableAttributedString(string: "Please answer the following questions accurately", attributes: [NSAttributedString.Key.font : UIFont(name: helveticaNeue_Bold, size: 26) ?? UIFont.boldSystemFont(ofSize: 26), NSAttributedString.Key.foregroundColor: UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
        
     label.attributedText = attributedTitle
     label.textColor = Constants.Design.Color.Primary.MarkerColor
     label.layer.shadowColor = UIColor.gray.cgColor
     label.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
     label.layer.shadowRadius = 1.0
     label.layer.shadowOpacity = 1.0
     label.layer.masksToBounds = false
        
     return label
    }()
    
    let ageLabel: UILabel = {
        
        let label = UILabel()
        label.labelConfigurations(text: "Are you over 18 years of age?", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
        return label
    }()
    
    let heartProblemLabel: UILabel = {
        
        let label = UILabel()
        label.labelConfigurations(text: "Do you have heart problems?", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
        return label
    }()
    
    let backProblemLabel: UILabel = {
        
        let label = UILabel()
        label.labelConfigurations(text: "Do you have back problems?", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
        return label
    }()
    
    let influenceLabel: UILabel = {
        
        let label = UILabel()
        label.labelConfigurations(text: "Are you under the influence of (drug/alcohol)?", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
        return label
    }()
    
    let pregnantLabel: UILabel = {
        
        let label = UILabel()
        label.labelConfigurations(text: " Are you pregnant?", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), fontSize: 16)
        return label
    }()
    
}
