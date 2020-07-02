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
    
    // presents clear icon within textfield
    func addClearButtonIcon() {

        let smallConfiguration = UIImage.SymbolConfiguration(scale: .small)
        let smallIcon = UIImage(systemName: "xmark.circle", withConfiguration: smallConfiguration)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        let iconView = UIImageView(frame: CGRect(x: 9, y: 11, width: 25, height: 25))
        iconView.image = smallIcon
    
        let iconContainerView: UIView = UIView(frame: CGRect(x: 30, y: 0, width: 50, height: 50))
        iconContainerView.addSubview(iconView)
        iconContainerView.isUserInteractionEnabled = true
    
        rightView = iconContainerView
        rightViewMode = .whileEditing
    }
}
