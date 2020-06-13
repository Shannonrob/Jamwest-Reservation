//
//  UIViewControllerExt.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/20/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // present VC from the right to left
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    // dismiss VC from left to right
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
    
    // add child viewController
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    // remove child viewController
    func remove(_ child: UIViewController) {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        child.willMove(toParent: nil)
        child.removeFromParent()
        child.view.removeFromSuperview()
    }
    
    // present viewController with or without fullScreen
    func handlePresentVC(with vc: UIViewController, fullscreen yes: Bool = true) {
        
        let viewController = vc
        let navigationController = UINavigationController(rootViewController: viewController)
        yes == true ? navigationController.modalPresentationStyle = .fullScreen : nil
        present(navigationController, animated: true)
    }
    
    // present EditReservationVC with index for enum case
    func presentEditReservationVC(index: Int) {
        
        let editReservationVC = EditReservationVC()
        let navigationController = UINavigationController(rootViewController: editReservationVC)
        editReservationVC.showInformation = ShowInformation.init(index: index)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func presentAddReservationVC(index: Int, with data: Reservation?) {
        
        let addReservationVC = AddReservationVC()
        let navigationController = UINavigationController(rootViewController: addReservationVC)
        addReservationVC.uploadAction = UploadAction.init(index: index)
        addReservationVC.reservation = data
        present(navigationController, animated: true)
    }
    
    // present cameraVC with selected case
    func presentCameraVC(for selectedCase: CameraAction, with values: Dictionary<String, Any>) {
        
        if  selectedCase == .CaptureProfileImage {
            let cameraVC = CameraVC()
            cameraVC.cameraAction = selectedCase
            cameraVC.participantWaiver = values
            navigationController?.pushViewController(cameraVC, animated: true)
            
        } else {
            
            let cameraVC = CameraVC()
            cameraVC.cameraAction = selectedCase
            cameraVC.participantWaiver = values
            navigationController?.pushViewController(cameraVC, animated: true)
        }
    }
    
    // push viewController onto navigationStack
    func pushVC(with vc: UIViewController) {
        
        let viewController = vc
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
