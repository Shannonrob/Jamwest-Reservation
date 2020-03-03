//
//  UIStackviewExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func configureStackView (alignment: Alignment?, distribution: Distribution?, spacing: CGFloat?) {
        
        if let alignment = alignment {
            self.alignment = alignment
        }
        if let distribution = distribution {
            self.distribution = distribution
        }
        
        if let spacing = spacing {
            self.spacing = spacing
        }
    }
}
