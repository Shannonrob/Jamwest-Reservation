//
//  PreviewImageVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/20/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class PreviewImageVC: UIViewController, PreviewImageDelegate {
    
    //    MARK: - Properties
    var previewImage: UIImage?
    var previewImageView = PreviewImageView()
    var participantWaiver = [String:Any]()
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        view = previewImageView
        
        previewImageView.photoPreview.image = previewImage
        previewImageView.previewImageDelegate = self
    }
    
    // hide navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        let loadingVC = LoadingVC()
        remove(loadingVC)
    }
    
    //    MARK: - Handlers
    
    // pop navigation controller back to previous viewController
    func handleRetakeButton(for vc: PreviewImageView) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // show navigationBar then pops to rootViewController
    func handleUsePhotoButton(for vc: PreviewImageView) {
        
        // disable buttons after tapped
        previewImageView.usePhotoButton.isEnabled = false
        previewImageView.retakePhotoButton.isEnabled = false
        
        Alert.showCompletionAlert(on: self, with: "Your waiver is complete!")
        
        uploadWaiverPhoto()
    }
    
    //    MARK: - API
    
    func uploadWaiverPhoto() {
        
        let loadingVC = LoadingVC()
        add(loadingVC)
        
        // image upload data
        guard let uploadData = previewImage?.jpegData(compressionQuality: 0.75) else { return }
        
        // post ID
        let waiverID = PARTICIPANT_WAIVER_REF.childByAutoId()
   
        // update storage
        WAIVER_IMAGE_REF.child("\(waiverID)").putData(uploadData, metadata: nil) { (metadata, error) in
            
            if let error = error {
               
                self.remove(loadingVC)
                
                Alert.showErrorMessage(on: self, with: "Failed to upload image to storage with error \(error.localizedDescription)")
                return
            }
            
            // download image url
            WAIVER_IMAGE_REF.child("\(waiverID)").downloadURL { (url, error) in
                
                if let error = error {
                    
                    self.remove(loadingVC)
                    
                    Alert.showErrorMessage(on: self, with: "Failed to upload image to storage with error \(error.localizedDescription)")
                    return
                    
                } else {
                    
                    // save url as string
                    guard let imageUrl = url?.absoluteString else { return }
                    
                    self.participantWaiver[Constant.imageURL] = imageUrl
                    
                    // upload information to database
                    waiverID.updateChildValues(self.participantWaiver)
                    
                    // pop to root view controller
                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
