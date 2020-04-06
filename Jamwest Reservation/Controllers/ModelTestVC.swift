//
//  ModelTestVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/19/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import PencilKit

class ModelTestVC: UIViewController {
    
    var canvasView: PKCanvasView!
    
    // this VC was a test for passing the data  using a model

//    var participantInformation = [ParticipantInformation]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = Constants.Design.Color.Background.FadeGray
//
//        for info in participantInformation {
//
//            print(info.firstName)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let canvasView = PKCanvasView(frame: view.bounds)
        self.canvasView = canvasView
        
        canvasView.backgroundColor = .lightGray
        canvasView.tool = PKInkingTool(.pen, color: .systemOrange, width: 10)
        
        view.addSubview(canvasView)
        canvasView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
}
