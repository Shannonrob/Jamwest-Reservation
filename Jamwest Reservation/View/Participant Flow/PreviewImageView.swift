//
//  PreviewImageView.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 4/17/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class PreviewImageView: UIView {

//    MARK: - Properties
    
    var previewImageDelegate: PreviewImageDelegate?
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // initialize constraints/views here
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //    MARK: - UIImageView
    var photoPreview: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    //    MARK: - UIView
    
    let navBarView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        return view
    }()
    
    //    MARK: - UIButton
    lazy var retakePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButton(title: "Retake photo", titleColor: .white, buttonColor: nil, cornerRadius: nil)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRetakeButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Color.Background.fadeGray.cgColor
        return button
    }()
    
    lazy var usePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButton(title: "Use photo", titleColor: .white, buttonColor: nil, cornerRadius: nil)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleUsePhotoButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Color.Background.fadeGray.cgColor
        return button
    }()
    
//    MARK: - Handlers
    
    @objc func handleRetakeButtonTapped() {
        previewImageDelegate?.handleRetakeButton(for: self)
    }
    
    @objc func handleUsePhotoButtonTapped() {
        previewImageDelegate?.handleUsePhotoButton(for: self)
    }
    
//    MARK: - Constraints
    
    func configureConstraints() {
        
        addSubview(navBarView)
        navBarView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        addSubview(retakePhotoButton)
        retakePhotoButton.anchor(top: navBarView.topAnchor, left: navBarView.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 142, height: 40)
        
        addSubview(usePhotoButton)
        usePhotoButton.anchor(top: nil, left: nil, bottom: nil, right: navBarView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 138, height: 40)
        usePhotoButton.centerYAnchor.constraint(equalTo: retakePhotoButton.centerYAnchor).isActive = true
        
        addSubview(photoPreview)
        photoPreview.anchor(top: navBarView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

}
