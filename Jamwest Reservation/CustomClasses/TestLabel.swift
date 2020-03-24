//
//  TestLabel.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/22/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class TestLabel: UILabel {
    
//    MARK: - Properties
    
    
//    MARK: - UILabels
    
    lazy var headerLabel: UILabel = {
        
        let header = UILabel()
        header.textColor = .darkText
        header.numberOfLines = 2
        header.textAlignment = .center
        header.font = UIFont.init(name: helveticaNeue_Medium, size: 22)
        header.attributedText = NSAttributedString(string: "WARNING,ASSUMPTION OF RISK, LIABILITY RELEASE, \n INDEMNITY AND HOLD HARMLESS AGREEMENT", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
        return header
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    
        
//        configureConstaint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConstaint() {
        
        addSubview(headerLabel)
        headerLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
