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
    var image: UIImage?
    
//    MARK: - UIImageView
    var photoPreview: UIImageView = {

        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
//    MARK: - UIView
    
    let topView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        return view
    }()
    
    
//    MARK: - UIButton
    lazy var retakePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButton(title: "Retake photo", titleColor: .white, buttonColor: nil, cornerRadius: nil)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Color.Background.FadeGray.cgColor
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
        button.layer.borderColor = Color.Background.FadeGray.cgColor
        return button
    }()
    
//    MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
    }
    
//    MARK: - Handlers
    
    @objc func handleUsePhoto() {
        
        let waiverVC = WaiverVC()
        let navigationController = UINavigationController(rootViewController: waiverVC)
        navigationController.modalPresentationStyle = .fullScreen
        presentDetail(navigationController)
    }
    
    @objc func handleDismiss() {
        dismissDetail()
    }
    
//    MARK: - Helper Functions

    func configureConstraints() {
        
        view.addSubview(topView)
        topView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        view.addSubview(retakePhotoButton)
        retakePhotoButton.anchor(top: topView.topAnchor, left: topView.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 142, height: 40)
        
        view.addSubview(usePhotoButton)
        usePhotoButton.anchor(top: nil, left: nil, bottom: nil, right: topView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 138, height: 40)
        usePhotoButton.centerYAnchor.constraint(equalTo: retakePhotoButton.centerYAnchor).isActive = true
        
        view.addSubview(photoPreview)
        photoPreview.anchor(top: topView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
