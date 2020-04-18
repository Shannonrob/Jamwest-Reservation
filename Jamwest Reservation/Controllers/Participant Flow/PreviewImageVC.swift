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
    var previewImage: UIImage?
    var previewImageView = PreviewImageView()
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewImageView.photoPreview.image = previewImage
    }
    
    override func loadView() {
        
//        waiverViews.waiverVCDelegate = self
        view = previewImageView
    }
    
    // hide navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //    MARK: - Handlers
    
    // show navigationBar then pops to rootViewController
    @objc func handleUsePhoto() {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleDismiss() {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
        
}
