//
//  UIButtonExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension UIButton {
    
    func configureButtonWithIcon (_ image: String?, title: String?, titleColor: UIColor?, buttonColor: UIColor?, cornerRadius: CGFloat?) {
        
        if let image = image {
            setImage(#imageLiteral(resourceName: image).withRenderingMode(.alwaysOriginal), for: .normal)
            imageView?.contentMode = .scaleAspectFit
        }
        
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        
        if let buttonColor = buttonColor {
            self.backgroundColor = buttonColor
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        semanticContentAttribute = .forceRightToLeft
        tintColor = .clear
        setTitleColor(.black, for: .selected)
    
    }
    
    func configureButton (title: String?, titleColor: UIColor?, buttonColor: UIColor?, cornerRadius: CGFloat?) {
        
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        
        if let buttonColor = buttonColor {
            self.backgroundColor = buttonColor
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        
        tintColor = .clear
        setTitleColor(.black, for: .selected)
    }
    
 
    func updateButtonIcon (_ image: String?) {
        if let image = image {
            setImage(#imageLiteral(resourceName: image).withRenderingMode(.alwaysOriginal), for: .normal)
            imageView?.contentMode = .scaleAspectFit
        }
    }
    
        /// Sets the background color to use for the specified button state.
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {

           let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)

           UIGraphicsBeginImageContext(minimumSize)

           if let context = UIGraphicsGetCurrentContext() {
             context.setFillColor(color.cgColor)
             context.fill(CGRect(origin: .zero, size: minimumSize))
           }

           let colorImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           self.clipsToBounds = true
           self.setBackgroundImage(colorImage, for: forState)
         }
    

    func selectedPackageButtonState(icon: String?, font: CGFloat?, enabled: Bool!) {
        
        if let icon = icon {
            setImage(#imageLiteral(resourceName: icon).withRenderingMode(.alwaysOriginal), for: .normal)
            imageView?.contentMode = .scaleAspectFit
        }
        
         if let font = font {
            titleLabel?.font = .boldSystemFont(ofSize: font)
        }
        
        if let enabled = enabled {
            self.isEnabled = enabled
        }
        
    }
    
    func unSelectedPackageButtonState(icon: String?, font: CGFloat?, enabled: Bool!) {
        
        if let icon = icon {
            setImage(#imageLiteral(resourceName: icon).withRenderingMode(.alwaysOriginal), for: .normal)
            imageView?.contentMode = .scaleAspectFit
        }
        
        if let font = font {
            titleLabel?.font = .systemFont(ofSize: font)
        }
        
        if let enabled = enabled {
            self.isEnabled = enabled
        }
    }
}

