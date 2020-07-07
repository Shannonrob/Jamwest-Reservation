//
//  JWEmptyStateView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 7/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class JWEmptyStateView: UIView {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "white_Jamwest_Logo")?.withTintColor(Color.Primary.heavyGreen)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configureUI()
    }
    
    private func configureUI(){
        
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        logoImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 630)
        
        messageLabel.anchor(top: logoImageView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 1, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
    }
}
