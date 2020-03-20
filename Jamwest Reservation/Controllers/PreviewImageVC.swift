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
    
    lazy var backButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButton(title: "Retake", titleColor: Constants.Design.Color.Primary.Orange, buttonColor: nil, cornerRadius: nil)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
//    MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
    }
    
    
//    MARK: - Handlers
    
    @objc func handleDismiss() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
//    MARK: - Helper Functions
    
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureConstraints() {
        
        view.addSubview(photoPreview)
        photoPreview.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(backButton)
        backButton.anchor(top: photoPreview.topAnchor, left: photoPreview.leftAnchor, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 50, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
