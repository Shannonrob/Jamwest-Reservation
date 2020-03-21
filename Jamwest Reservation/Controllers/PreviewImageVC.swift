//
//  PreviewImageVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/20/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class PreviewImageVC: UIViewController {
    
//    MARK: - Properties
//
    var photoPreview: UIImageView = {

        let imageView = UIImageView()
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var retakePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButton(title: "Retake photo", titleColor: .white, buttonColor: nil, cornerRadius: nil)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Constants.Design.Color.Background.FadeGray.cgColor
        return button
    }()
    
    lazy var usePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButton(title: "Use photo", titleColor: .white, buttonColor: nil, cornerRadius: nil)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleUsePhoto), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Constants.Design.Color.Background.FadeGray.cgColor
        return button
    }()
    
//    MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
    }
    
//    MARK: - Handlers
    
    @objc func handleUsePhoto() {
        print("use photo tapped")
    }
    
    @objc func handleDismiss() {
        dismissDetail()
    }
    
//    MARK: - Helper Functions

    func configureConstraints() {
        
        view.addSubview(retakePhotoButton)
        retakePhotoButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 142, height: 40)
        
        view.addSubview(usePhotoButton)
        usePhotoButton.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 138, height: 40)
        usePhotoButton.centerYAnchor.constraint(equalTo: retakePhotoButton.centerYAnchor).isActive = true
        
        view.addSubview(photoPreview)
        photoPreview.anchor(top: retakePhotoButton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
