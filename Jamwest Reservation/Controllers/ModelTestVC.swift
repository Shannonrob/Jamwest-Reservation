//
//  ModelTestVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/19/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

class ModelTestVC: UIViewController {

    var participantInformation = [ParticipantInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Constants.Design.Color.Background.FadeGray
        
        for info in participantInformation {
            
            print(info.firstName)
        }
    }
}
