//
//  WaiverVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import PencilKit

class WaiverVC: UIViewController, WaiverVCDelegates {
    
    //    MARK: - Properties
    var waiverViews = WaiverViews()
    var participantInformation = [ParticipantInformation]()
    let image = #imageLiteral(resourceName: "greenJamwestLogo").withRenderingMode(.alwaysOriginal)
    var pkCanvasView: PKCanvasView!
    var reservation : Reservation!
    var underAgeParticipant: Bool?
    
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        enableGaurdianButton(with: underAgeParticipant!)
        presentData()
        pkCanvasView = waiverViews.canvasView
    }
    
    override func loadView() {
        
        waiverViews.waiverVCDelegate = self
        view = waiverViews
    }
    
    //    MARK: - Protocols
    
    func handleAgreeButton() {
        waiverViews.agreeButton.updateButtonIcon("greenSelectedCheckMark")
        handleAnimate()
    }
    
    func handleGuardianAcceptButton() {
        waiverViews.guardianAcceptButton.updateButtonIcon("greenSelectedCheckMark")
    }
    
    func handleClearButton() {
        undoManager?.undo()
    }
    
    func handleCancelButton() {
        dismissDetail()
    }
    
    func handleDoneButton() {
        
        // check if canvasView has drawing then present CameraVC else shows alert
        if !waiverViews.canvasView.drawing.bounds.isEmpty {
            
            let cameraVC = CameraVC()
            cameraVC.modalPresentationStyle = .fullScreen
            presentDetail(cameraVC)
            
        } else {
            Alert.signatureRequiredMessage(on: self, with: "Your signature is required to complete the Waiver & Release of Liability")
        }
    }
    
    
    //    MARK:- Helper Functions
    
    // animate canvasContainerView to show upon agree button tapped
    func handleAnimate() {
        
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
    
    // enables guardianButton if participant is underAge
    func enableGaurdianButton(with condition: Bool) {
        
        switch condition {
        case true:
            waiverViews.guardianAcceptButton.isEnabled = true
        case false:
            waiverViews.guardianAcceptButton.isEnabled = false
        }
    }
    
    func presentData() {
        
        // loop participant information and present it in waiver labels
        for data in participantInformation {
            
            waiverViews.nameLabel.text = "Name : \(data.firstName) \(data.lastName)"
            waiverViews.phoneNumberLabel.text = "Phone# \(data.phoneNumber)"
            waiverViews.dateLabel.text = "Date : \(data.currentDate)"
            waiverViews.emailLabel.text = "Email : \(data.emailAddress)"
            waiverViews.countryLabel.text = "Country : \(data.country)"
            waiverViews.paxLabel.text = "Pax : \(data.groupCount)"
        }
        
        // loop reservation information and present it in waiver labels
        for data in [reservation] {
            
            var tours = String()
            // check if data is nil
            guard let hotel = data?.hotel,
                let time = data?.time,
                let voucher = data?.voucherNumber,
                let tourRep = data?.tourRep,
                let tourComp = data?.tourCompany else { return }
            
            // check if tours are nill and append it to tours label
            if let firstTour = data?.firstTour { tours.append(firstTour) }
            if let secondTour = data?.secondTour { tours.append(", \(secondTour)") }
            if let thirdTour = data?.thirdTour { tours.append(", \(thirdTour)") }
            if let fourthTour = data?.fourthTour { tours.append(", \(fourthTour)") }
            
            // configure labels with data to present
            waiverViews.hotelLabel.text = "Hotel : \(hotel)"
            waiverViews.reservationTimeLabel.text = "Time : \(time)"
            waiverViews.voucherLabel.text = "Voucher# \(voucher)"
            waiverViews.tourRepLabel.text = "Tour Representative : \(tourRep)"
            waiverViews.tourCompanyLabel.text = "Tour Company : \(tourComp)"
            waiverViews.toursLabel.text = "Tour(s) : \(tours)"
        }
    }
    
    
    func configureUI() {
        
        view.backgroundColor = Constants.Design.Color.Background.FadeGray
    }
}

// extension to manually opperate scrollView
extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
    }
}
