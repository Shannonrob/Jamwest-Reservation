//
//  UITextfieldExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension UITextField {
    
    func design(placeHolder: String?, backgroundColor: UIColor?, fontSize: CGFloat?, textColor: UIColor?, borderStyle: BorderStyle?, width: CGFloat, height: CGFloat) {
        
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let font = fontSize {
            self.font = UIFont.systemFont(ofSize: font)
        }
        
        if placeHolder != nil {
            self.attributedPlaceholder = NSAttributedString(string: placeHolder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        }
        
        if let borderStyle = borderStyle {
            self.borderStyle = borderStyle
        }
        
        if width != 0 {
               widthAnchor.constraint(equalToConstant: width).isActive = true
           }
               
           if height != 0 {
               heightAnchor.constraint(equalToConstant: height).isActive = true
           }
    }
    
    // placeholder with image used in ParticipantInfoVC
    func configurePlaceHolderWithIcon(_ placeHolder: String?, _ image: UIImage) {
        
        if placeHolder != nil {
            self.attributedPlaceholder = NSAttributedString(string: placeHolder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        }
        
        let iconView = UIImageView(frame: CGRect(x: -10, y: 0, width: 50, height: 50))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 30, y: 0, width: 50, height: 50))
        iconContainerView.addSubview(iconView)
        
        rightView = iconContainerView
        rightViewMode = .unlessEditing
    }
    
    
    // textfield icon
    func setTextfieldIcon(_ image: UIImage) {
        
        let iconView = UIImageView(frame: CGRect(x: -10, y: 0, width: 50, height: 50))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 30, y: 0, width: 50, height: 50))
        iconContainerView.addSubview(iconView)
        
        rightView = iconContainerView
        rightViewMode = .unlessEditing
        
    }
    
    // clearButton
    func textfieldClearButtonIcon(_ image: UIImage) {
        
        let iconView = UIImageView(frame: CGRect(x: -10, y: 0, width: 50, height: 50))
        iconView.image = image
    
        let iconContainerView: UIView = UIView(frame: CGRect(x: 30, y: 0, width: 50, height: 50))
        iconContainerView.addSubview(iconView)
        iconContainerView.isUserInteractionEnabled = true
    
        rightView = iconContainerView
        rightViewMode = .whileEditing
    }
}
