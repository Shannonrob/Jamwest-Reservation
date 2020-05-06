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
    func handleDoneButton()
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
