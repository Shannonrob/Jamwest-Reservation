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
            
            waiverViews.nameLabel.attributedText = configureAttributes(with: "Name:  ", append: "\(data.firstName) \(data.lastName)")
            waiverViews.phoneNumberLabel.attributedText = configureAttributes(with: "Phone#  ", append: "\(data.phoneNumber)")
            waiverViews.dateLabel.attributedText = configureAttributes(with: "Date:  ", append: "\(data.currentDate)")
            waiverViews.emailLabel.attributedText = configureAttributes(with: "Email:  ", append: "\(data.emailAddress)")
            waiverViews.countryLabel.attributedText = configureAttributes(with: "Country:  ", append: "\(data.country)")
        }
        
        // loop reservation information and present it in waiver labels
        for data in [reservation] {
            
            var tours = String()
            // check if data is nil
            guard let hotel = data?.hotel,
                let time = data?.time,
                let voucher = data?.voucherNumber,
                let tourRep = data?.tourRep,
                let groupCount = data?.pax,
                let tourComp = data?.tourCompany else { return }
            
            // check if tours are nill and append it to tours label
            if let firstTour = data?.firstTour { tours.append(firstTour) }
            if let secondTour = data?.secondTour { tours.append(", \(secondTour)") }
            if let thirdTour = data?.thirdTour { tours.append(", \(thirdTour)") }
            if let fourthTour = data?.fourthTour { tours.append(", \(fourthTour)") }
            
            // configure labels with data to present
            waiverViews.hotelLabel.attributedText = configureAttributes(with: "Hotel:  ", append: "\(hotel)")
            waiverViews.reservationTimeLabel.attributedText = configureAttributes(with: "Time:  ", append: "\(time)")
            waiverViews.voucherLabel.attributedText = configureAttributes(with: "Voucher#  "  , append: "\(voucher)")
            waiverViews.tourRepLabel.attributedText = configureAttributes(with: "Tour Representative:  ", append: "\(tourRep)")
            waiverViews.tourCompanyLabel.attributedText = configureAttributes(with: "Tour Company:  ", append: "\(tourComp)")
            waiverViews.toursLabel.attributedText = configureAttributes(with: "Tour(s):  ", append: "\(tours)")
            waiverViews.paxLabel.attributedText = configureAttributes(with: "Pax:  ", append: "\(groupCount)")
        }
    }
    
    func configureAttributes(with title: String, append dataTitle: String) -> NSAttributedString {

        let attributedTitle = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.init(name: Font.helveticaNeueBold, size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        attributedTitle.append(NSAttributedString(string: dataTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
    
        return attributedTitle
    }
    
    
    func configureUI() {
        
        view.backgroundColor = Color.Background.FadeGray
    }
}

// extension to manually opperate scrollView
extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(scrollView: self), animated: animated)
    }
}
