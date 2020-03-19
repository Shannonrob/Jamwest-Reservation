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
    
    func handlePresentPickerView(for textfield: NSObject)
    func handlePickerViewDoneButton()
    func handleSelectedAnswers(for button: NSObject)
}
