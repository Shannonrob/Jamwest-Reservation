//
//  PreviewImageVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/20/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class PreviewImageVC: UIViewController, PreviewImageDelegate {
    
    //    MARK: - Properties
    var previewImage: UIImage?
    var previewImageView = PreviewImageView()
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = previewImageView
        
        previewImageView.photoPreview.image = previewImage
        previewImageView.previewImageDelegate = self
    }
    
    // hide navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //    MARK: - Handlers
    
    
    func handleRetakeButton(for vc: PreviewImageView) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    // show navigationBar then pops to rootViewController
    func handleUsePhotoButton(for vc: PreviewImageView) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
