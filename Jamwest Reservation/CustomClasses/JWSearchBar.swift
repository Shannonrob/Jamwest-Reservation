//
//  JWSearchBar.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 6/29/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JWSearchBar: UISearchBar {
    
    convenience init(placeHolder: String){
        self.init(frame: .zero)
        placeholder = placeHolder
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSearchBar() {
        
        sizeToFit()
        barStyle = .black
        searchTextField.textColor = .white
    }
}
