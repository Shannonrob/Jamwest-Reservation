//
//  Protocols.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import Foundation

protocol HomeVcDelegate {
  
    func handleMenuToggle(forMenuOption menuOption: MenuOption?)
}

protocol ParticipantInfoViewsDelegate: class {
    
    func handlePresentPickerView()
    func handlePickerViewDoneButton()
    func handleSelectedAnswers(for button: NSObject)
}

protocol WaiverVCDelegates: class {
    
    func handleAgreeButton()
    func handleGuardianAcceptButton()
    func handleCancelButton()
    func handleIAgreeButton()
    func handleClearButton()
}

protocol PreviewImageDelegate {
    
    func handleRetakeButton(for vc: PreviewImageView)
    func handleUsePhotoButton(for vc: PreviewImageView)
}

protocol WaiverVerificationCellDelegate {
    
    func handleReviewButtonTapped(for cell: WaiverVerificationCell)
    func handleApproveButtonTapped(for cell: WaiverVerificationCell)
}

protocol ReviewWaiverDelegate {
    
    func handleRejectButton(for vc: ReviewView)
    func handleApproveButton(for vc: ReviewView)
    func handleCameraButton(for vc: ReviewView)
    func handleDismissButtonTapped(for vc: ReviewView)
}

protocol VerificationDelegate {
    func handleSegmentedControl(for vc: VerificationView)
}

protocol AddReservationDelegate {
    
    func handleFormValidation(for vc: AddReservationView, with sender: NSObject)
    func handleShowDatePicker(for vc: AddReservationView)
    func handleStepperTapped(for vc: AddReservationView)
    func handleSegmentControl(for vc: AddReservationView)
}

protocol TourSelectionDelegate {
    func handleSubmitButton(for vc: TourSelectionView)
}
