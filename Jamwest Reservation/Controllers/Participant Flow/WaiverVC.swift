//
//  WaiverVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import PencilKit
import Firebase

class WaiverVC: UIViewController, WaiverVCDelegates {
    
    //    MARK: - Properties
    var waiverViews = WaiverViews()
    var participantInformation = [ParticipantInformation]()
    let image = #imageLiteral(resourceName: "greenJamwestLogo").withRenderingMode(.alwaysOriginal)
    var pkCanvasView: PKCanvasView!
    var reservation: Reservation!
    var reservationID: String!
    var paxCount: Int!
    var isUnderAge: Bool?
    var guardianAgreed = false
    var currentDate: String!
    var participantWaiver = [String:Any]()
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presentData()
        shouldShowGaurdianAgreement(if: isUnderAge!)
        pkCanvasView = waiverViews.canvasView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func loadView() {
        waiverViews.waiverVCDelegate = self
        view = waiverViews
    }
    
    //    MARK: - Protocols
    
    func handleAgreeButton() {
        if waiverViews.guardianLabel.isHidden == false && guardianAgreed == false {
            Alert.showRequiredMessage(on: self, with: "Parent/Gaurdian must agree to signing on behalf of minor")
        } else {
            waiverViews.agreeButton.updateButtonIcon("greenSelectedCheckMark")
            animateSignatureCanvas()
        }
    }
    
    func handleGuardianAcceptButton() {
        waiverViews.guardianAcceptButton.updateButtonIcon("greenSelectedCheckMark")
        guardianAgreed = true
    }
    
    func handleClearButton() {
        undoManager?.undo()
    }
    
    func handleCancelButton() {
        // return to previous ViewController and show navigationBar
        _ = navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func handleIAgreeButton() {
        // check if canvasView has drawing then present CameraVC else shows alert
        if !waiverViews.canvasView.drawing.bounds.isEmpty {
            waiverViews.doneButton.isEnabled = false
            
            // update pax value or delete reservation
            self.reservation.updateWaiverBalance(for: self.currentDate)
            presentCamera()
        } else {
            Alert.signatureRequiredMessage(on: self, with: JWError.signatureRequired.rawValue)
        }
    }
    
    //    MARK:- Helper Functions
    
    func popToRootVC() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
        Alert.showCompletionAlert(on: self, with: ErrorMessage.waiverCompletedMessage)
    }
    
    // animate canvasContainerView to show upon agree button tapped
    func animateSignatureCanvas() {
        waiverViews.canvasContainerViewHeight = waiverViews.canvasContainerView.heightAnchor.constraint(equalToConstant: 280)
        waiverViews.canvasContainerViewHeight?.isActive = true
        waiverViews.canvasViewHeight = waiverViews.canvasView.heightAnchor.constraint(equalToConstant: 240)
        waiverViews.canvasViewHeight?.isActive = true
        waiverViews.clearButton.isHidden = false
        waiverViews.signHereLabel.isHidden = false
        waiverViews.signatureLineView.isHidden = false
        waiverViews.doneButton.isEnabled = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.waiverViews.scrollView.scrollTo(direction: .Bottom, animated: true)
        }, completion: nil)
    }
    
    
    // enables and show guardianButton if participant is underAge
    func shouldShowGaurdianAgreement(if condition: Bool) {
        
        switch condition {
        case true:
            waiverViews.guardianAcceptButton.isHidden = false
            waiverViews.guardianLabel.isHidden = false
            waiverViews.guardianAcceptButton.isEnabled = true
        case false:
            waiverViews.guardianAcceptButton.isHidden = true
            waiverViews.guardianLabel.isHidden = true
            waiverViews.guardianAcceptButton.isEnabled = false
        }
    }
    
    func presentData() {
        
        // loop participant information and present it in waiver labels
        for data in participantInformation {
            
            waiverViews.nameLabel.attributedText = UILabel.configureAttributes(with: "Name:  ", append: "\(data.firstName) \(data.lastName)")
            waiverViews.phoneNumberLabel.attributedText = UILabel.configureAttributes(with: "Phone#  ", append: "\(data.phoneNumber)")
            waiverViews.dateLabel.attributedText = UILabel.configureAttributes(with: "Date:  ", append: "\(data.currentDate)")
            waiverViews.emailLabel.attributedText = UILabel.configureAttributes(with: "Email:  ", append: "\(data.emailAddress)")
            waiverViews.countryLabel.attributedText = UILabel.configureAttributes(with: "Country:  ", append: "\(data.country)")
            
            // pass boolean
            isUnderAge = data.ageAnswer
            currentDate = data.currentDate
            
            configureGuardianLabel(with: data.guardianName, of: "\(data.firstName) \(data.lastName)", if: data.ageAnswer)
            
            // append participant information to dictionary
            participantWaiver[Constant.firstName] = data.firstName
            participantWaiver[Constant.lastName] = data.lastName
            participantWaiver[Constant.fullName] = data.fullName.lowercased()
            participantWaiver[Constant.fullNameReversed] = data.fullNameReversed.lowercased()
            participantWaiver[Constant.pregnantAnswer] = data.pregnantAnswer
            participantWaiver[Constant.minorAnswer] = data.ageAnswer
            participantWaiver[Constant.underInfluenceAnswer] = data.underInfluenceAnswer
            participantWaiver[Constant.heartAnswer] = data.heartProblemAnswer
            participantWaiver[Constant.backAnswer] = data.backProblemAnswer
            participantWaiver[Constant.creationDate] = data.currentDate
            participantWaiver[Constant.emailAddress] = data.emailAddress
        }
        
        
        // loop reservation information and present it in waiver labels
        for data in [reservation] {
            
            var tours = String()
            // check if data is nil
            guard let hotel = data?.hotel,
                let reservationID = data?.reservationId,
                let time = data?.time,
                let voucher = data?.voucherNumber,
                let tourRep = data?.tourRep,
                let groupCount = data?.pax,
                let tourComp = data?.tourCompany else { return }
            
            self.reservationID = reservationID
            self.paxCount = groupCount
            
            // check if tours are nill and append it to tours array
            if let firstTour = data?.firstTour { tours.append(firstTour) }
            if let secondTour = data?.secondTour { tours.append(", \(secondTour)") }
            if let thirdTour = data?.thirdTour { tours.append(", \(thirdTour)") }
            if let fourthTour = data?.fourthTour { tours.append(", \(fourthTour)") }
            
            // configure labels with data to present
            waiverViews.hotelLabel.attributedText = UILabel.configureAttributes(with: "Hotel:  ", append: "\(hotel)")
            waiverViews.reservationTimeLabel.attributedText = UILabel.configureAttributes(with: "Time:  ", append: "\(time)")
            waiverViews.voucherLabel.attributedText = UILabel.configureAttributes(with: "Voucher#  "  , append: "\(voucher)")
            waiverViews.tourRepLabel.attributedText = UILabel.configureAttributes(with: "Tour Representative:  ", append: "\(tourRep)")
            waiverViews.tourCompanyLabel.attributedText = UILabel.configureAttributes(with: "Tour Company:  ", append: "\(tourComp)")
            waiverViews.toursLabel.attributedText = UILabel.configureAttributes(with: "Tour(s):  ", append: "\(tours)")
            waiverViews.paxLabel.attributedText = UILabel.configureAttributes(with: "Pax:  ", append: "\(groupCount)")
            
            // append participant information to dictionary
            participantWaiver[Constant.firstTour] = data?.firstTour
            participantWaiver[Constant.secondTour] = data?.secondTour
            participantWaiver[Constant.thirdTour] = data?.thirdTour
            participantWaiver[Constant.fourthTour] = data?.fourthTour
        }
    }
    
    
    //configure guardian agreement label
    func configureGuardianLabel(with guardian: String, of minor: String, if state: Bool) {
        state == true ? waiverViews.guardianLabel.text = "I \(guardian) is signing this waiver of liability on the behalf of \(minor)" : nil
    }
    
    func configureUI() {
        view.backgroundColor = Color.Background.fadeGray
    }
    
    //MARK: - Api
    
    func postWaiver(with waiverID: DatabaseReference?) {
        
        NetworkManager.shared.postWaiver(with: participantWaiver, waiver: waiverID) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let waiverID):
                DispatchQueue.global(qos: .background).async { self.postEmail(with: waiverID.key!) }
                
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func createCompletedWaiver(with image: UIImage) {
        
        DispatchQueue.main.async { self.showLoadingView()}
        
        guard let uploadData = image.jpegData(compressionQuality: 0.75) else { return }
        NetworkManager.shared.postCompletedWaiver(with: uploadData) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let results):
                DispatchQueue.main.async { self.popToRootVC() }
                
                var url: String!
                var waiverID: DatabaseReference!
                
                for download in results {
                    waiverID = download.key
                    url = download.value
                }
                
                self.participantWaiver[Constant.imageURL] = url
                self.postWaiver(with: waiverID)
                
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
    
    
    func postEmail(with waiverID: String) {
        
        guard let emailAddress = participantWaiver[Constant.emailAddress] as? String else { return }
        guard let firstName = participantWaiver[Constant.firstName],
            let lastName = participantWaiver[Constant.lastName],
            let fullName = participantWaiver[Constant.fullName],
            let fullNameReversed = participantWaiver[Constant.fullNameReversed] else { return}
        
        if emailAddress != "" {
            let values = [Constant.emailAddress : emailAddress,
                          Constant.firstName: firstName,
                          Constant.lastName: lastName,
                          Constant.fullName: fullName,
                          Constant.fullNameReversed: fullNameReversed]
            
            NetworkManager.shared.postEmail(with: waiverID, values: values)
        }
    }
}

// extension to manually opperate scrollView
extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
    }
}

extension WaiverVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.cameraDevice = .front
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            DispatchQueue.global(qos: .background).async {
                self.postWaiver(with: nil)
            }
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            Alert.showAlert(on: self, with: JWError.malfunction.rawValue)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            self.createCompletedWaiver(with: image)
        }
        
        picker.dismiss(animated: true)
    }
}

