//
//  JamwestDefaultView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/22/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JamwestDefaultView: UIView {

     override init(frame: CGRect) {
           super.init(frame: .zero)
           
       }
       
       convenience init() {
           self.init(frame: CGRect.zero)
           test()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    func test() {
        layer.cornerRadius = 8
        layer.borderWidth = 0.25
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 2.75
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
    
        backgroundColor = .white
    }
}
