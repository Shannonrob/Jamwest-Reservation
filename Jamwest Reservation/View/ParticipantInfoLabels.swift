//
//  ParticipantInfoLabels.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/6/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ParticipantInfoLabels: UILabel {

    let testLabel: UILabel = {

     let label = UILabel()
     label.labelConfigurations(text: " Test Label", textColor: .darkGray, fontSize: 16)
     return label
    }()
}
