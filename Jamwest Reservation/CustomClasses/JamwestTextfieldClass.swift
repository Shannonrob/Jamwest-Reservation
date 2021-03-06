//
//  JamwestTextfieldClass.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JamwestTextfieldClass: UITextField {
    
    convenience init(icon: UIImage, placeholder: String, keyboardType: UIKeyboardType) {
        self.init(frame: .zero)
        
        setTextfieldIcon(icon)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.keyboardType = keyboardType
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
    
    override init(frame: CGRect) {
    super.init(frame: .zero)
    
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        font?.withSize(18)
        layer.borderWidth = 0.85
        layer.cornerRadius = 4
        layer.masksToBounds = true
        borderStyle = .roundedRect
        returnKeyType = .next
        layer.borderColor = Color.Border.blue
        widthAnchor.constraint(equalToConstant: 400).isActive = true
        heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ParticipantTextField: UITextField {
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        font?.withSize(18)
        layer.borderWidth = 0.85
        layer.cornerRadius = 4
        layer.masksToBounds = true
        borderStyle = .roundedRect
        layer.borderColor = Color.Border.blue
        heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddReservationTextField: UITextField {
    
    convenience init(icon: UIImage, placeholder: String, width: CGFloat) {
        self.init(frame: .zero)
        
        setTextfieldIcon(icon)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        textColor = .black
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 18)
        borderStyle = .roundedRect
        layer.borderWidth = 0.85
        layer.borderColor = Color.Border.blue
        layer.cornerRadius = 4
        layer.masksToBounds = true
        returnKeyType = .next
        heightAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



