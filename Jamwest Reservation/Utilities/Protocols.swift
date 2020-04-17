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

protocol ReservationCellDelegate {
    
    func handleMenuTapped(for cell: ReservationCell)
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
