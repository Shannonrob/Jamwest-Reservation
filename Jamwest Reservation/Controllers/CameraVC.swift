//
//  CameraVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/20/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController {

//    MARK: - Properties
    // define AVFoundation variable
   
    
    lazy var takePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButtonWithIcon("greenCamera", title: nil, titleColor: nil, buttonColor: .white, cornerRadius: 6)
        button.addTarget(self, action: #selector(handleTakePhotoTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        configureConstraints()
        setupCamera()
    }
    
//    MARK: - Handlers
    @objc func handleTakePhotoTapped() {
        
        let previewImageVC = PreviewImageVC()
        navigationController?.pushViewController(previewImageVC, animated: true)
    }
    
//    MARK: - Helper Functions
    
    func setupCamera() {
    
    }
    
    func configureConstraints() {
        
        view.addSubview(takePhotoButton)
        takePhotoButton.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 100, height: 0)
        takePhotoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
