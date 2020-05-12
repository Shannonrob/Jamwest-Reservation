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
        super.viewWillAppear(true)
        
        // hide navigationBar
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func loadView() {
        
        waiverViews.waiverVCDelegate = self
        view = waiverViews
    }
    
    //    MARK: - Protocols
    
    func handleAgreeButton() {
        
        if waiverViews.guardianLabel.isHidden == false && guardianAgreed == false {
            
            Alert.showGuardianReqiuredMessage(on: self, with: "Parent/Gaurdian must accept signing on behalf of minor")
            
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
    
    func handleDoneButton() {
        
        // check if canvasView has drawing then present CameraVC else shows alert
        if !waiverViews.canvasView.drawing.bounds.isEmpty {
            
            // handles the data
            uploadParticipantWaiver()
            waiverViews.doneButton.isEnabled = false
            
        } else {
            Alert.signatureRequiredMessage(on: self, with: "Your signature is required to complete the Waiver & Release of Liability")
        }
    }
    
    //    MARK:- Helper Functions
    
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
            participantWaiver[Constant.name] = "\(data.firstName) \(data.lastName)"
            participantWaiver[Constant.pregnantAnswer] = data.pregnantAnswer
            participantWaiver[Constant.minorAnswer] = data.ageAnswer
            participantWaiver[Constant.underInfluenceAnswer] = data.underInfluenceAnswer
            participantWaiver[Constant.heartAnswer] = data.heartProblemAnswer
            participantWaiver[Constant.backAnswer] = data.backProblemAnswer
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
    
//    MARK: - API
    
    func uploadParticipantWaiver() {

        // creation date
        let creation = Int(NSDate().timeIntervalSince1970)
        participantWaiver[Constant.creationDate] = creation
        
        // post ID
        let waiver = PARTICIPANT_WAIVER_REF.childByAutoId()
        
        // upload information to database
        waiver.updateChildValues(participantWaiver)
        
        // update pax value or delete reservation
        self.reservation.updateWaiverBalance(for: self.currentDate)

        // transition to cameraVC
        let cameraVC = CameraVC()
        cameraVC.waiverID = waiver.key
        self.navigationController?.pushViewController(cameraVC, animated: true)
    }
}

// extension to manually opperate scrollView
extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
    }
}

