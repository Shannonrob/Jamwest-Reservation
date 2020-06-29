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
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    var participantWaiver = [String:Any]()
    var cameraAction: CameraAction!
    
    // values for Timer
    var startValue = Int()
    let endValue = 1
    var timer: Timer?
    
//    MARK: - UILabels
    let countDownLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60)
        label.font = .boldSystemFont(ofSize: 80)
        return label
    }()
    
//    MARK: - UIButtons
    lazy var takePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.updateButtonIcon("grayCamera")
        button.addTarget(self, action: #selector(handleStartTimer), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0.75
        button.layer.borderColor = Color.Background.fadeGray.cgColor
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.configureButton(title: "Cancel", titleColor: .white, buttonColor: nil, cornerRadius: nil)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleCancelTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 1.5
        button.layer.borderColor = Color.Background.fadeGray.cgColor
        return button
    }()
    
//    MARK: - UIView
    let bottomView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60)
        return view
    }()
    
//    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        configureConstraints()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startValue = 3
        countDownLabel.text = "\(startValue)"
        takePhotoButton.isEnabled = true
        cancelButton.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        countDownLabel.isHidden = true
    }
    
//    MARK: - Handlers
   
    @objc func handleCancelTapped() {
        
        presentAlert()
    }
    
    // start CADisplayLink
    @objc func handleStartTimer() {
        
        takePhotoButton.isEnabled = false
        cancelButton.isEnabled = false
        countDownLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        
         if startValue == endValue {
            
            countDownLabel.text = "\(endValue)"
            timer!.invalidate()
            snapPhoto()
         } else {
            
            startValue -= endValue
            countDownLabel.text = "\(startValue)"
         }
    }
    
    
//    MARK: - Helper Functions
    
    // alerts use when cancel is tapped
    func presentAlert() {
        
        let alertController = UIAlertController(title: "Warning", message: "Waiver will be incomplete!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Continue", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
          
            // upload waiver details to backEnd
            self.cameraAction == .CaptureProfileImage ? self.uploadWaiver() : nil
            
            // show navigationBar then pops to rootViewController
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        let deleteAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(deleteAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentPreviewVC() {
        
        let previewImageVC = PreviewImageVC()
        previewImageVC.previewImage = rotateImage(image: self.image!)
        previewImageVC.participantWaiver = self.participantWaiver
        previewImageVC.cameraAction = self.cameraAction
        navigationController?.pushViewController(previewImageVC, animated: true)
    }
    
    func snapPhoto() {
           
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    // rotate image after capture session
    func rotateImage(image:UIImage) -> UIImage {
      
        var rotatedImage = UIImage()
       
        switch image.imageOrientation {
        case .right:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .down)
        case .down:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .left)
        case .left:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up)
        default:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .right)
        }
        return rotatedImage
    }
    
    // setup camera methods
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
    
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamera = frontCamera
    }
    
    func setupInputOutput() {
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setupPreviewLayer() {
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
     
        captureSession.startRunning()
    }
    
//    MARK: - Constraints
    func configureConstraints() {
        
        view.addSubview(takePhotoButton)
        takePhotoButton.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 60, height: 60)
        takePhotoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(bottomView)
        bottomView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 140)
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: nil, left: view.leftAnchor, bottom: bottomView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 20, paddingRight: 0, width: 108, height: 36)
        
        view.addSubview(countDownLabel)
        countDownLabel.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        countDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    //MARK: - Api
    
    // upload waiver without image if user exits
    func uploadWaiver() {

        // post ID
        let waiverID = PARTICIPANT_WAIVER_REF.childByAutoId()
        
        // upload information to database
        waiverID.updateChildValues(participantWaiver)
        
        uploadEmailList(with: waiverID.key!)
    }
    
    func uploadEmailList(with waiverID: String) {
        
        // check if values exist and upload email to list
        guard let emailAddress = participantWaiver[Constant.emailAddress] as? String else { return }
        guard let name = participantWaiver[Constant.name] else { return}
        
        // check for value and upload to database
        if emailAddress != "" {
           
            let values = [Constant.emailAddress : emailAddress, Constant.name: name ]
            
            PARTICIPANT_EMAIL_REF.child(waiverID).updateChildValues(values)
        }
    }
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            presentPreviewVC()
        }
    }
}
