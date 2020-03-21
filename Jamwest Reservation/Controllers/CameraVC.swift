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
    
//    MARK: - UIButtons
    lazy var takePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.updateButtonIcon("grayCamera")
        button.addTarget(self, action: #selector(handleTakePhotoTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.60)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 0.75
        button.layer.borderColor = Constants.Design.Color.Background.FadeGray.cgColor
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
        button.layer.borderColor = Constants.Design.Color.Background.FadeGray.cgColor
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
    
//    MARK: - Handlers
    @objc func handleTakePhotoTapped() {
        
        let previewImageVC = PreviewImageVC()
        previewImageVC.modalPresentationStyle = .fullScreen
        presentDetail(previewImageVC)
    }
    
    @objc func handleCancelTapped() {
        //extension used to dismiss like a viewController
        dismissDetail()
    }
    
    
//    MARK: - Helper Functions
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        // set front camera as default #test
//        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.front)
        
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
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
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
    
    
    func configureConstraints() {
        
        view.addSubview(takePhotoButton)
        takePhotoButton.anchor(top: nil, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 40, width: 60, height: 60)
        takePhotoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(bottomView)
        bottomView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 140)
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: nil, left: view.leftAnchor, bottom: bottomView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 20, paddingRight: 0, width: 108, height: 36)
    }
}
