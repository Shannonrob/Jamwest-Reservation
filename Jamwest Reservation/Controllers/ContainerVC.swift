//
//  ContainerVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class ContainerVC: UIViewController {
 
//    MARK: - Properties

    var menuVC: MenuVC!
    var menuOption: MenuOption!
    var centerController: UIViewController!
    var isExpanded = false

//    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            presentLoginVC()
        } else {
            presentHomeVC()
            // adds shadow to HomeVC
            addShadow()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return.slide
    }
    
    override var prefersStatusBarHidden: Bool{
        return  isExpanded
    }
    
//    MARK: - Handlers
    
    func presentHomeVC() {
        let homeVC = HomeVC(collectionViewLayout: UICollectionViewFlowLayout())
        homeVC.delegate = self
        centerController = UINavigationController(rootViewController: homeVC)

        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func presentLoginVC() {
        let loginVC = LoginVC()
        centerController = UINavigationController(rootViewController: loginVC)

        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    
    func configureMenuVC() {
        if menuVC == nil {
//            add menu controller here
            menuVC = MenuVC()
            menuVC.delegate = self
            view.insertSubview(menuVC.view, at: 0)
            addChild(menuVC)
            menuVC.didMove(toParent: self)
        }
    }
    
    func presentWaiverVC () {
        
        let waiverVC = WaiverVC()
        let navigationController = UINavigationController(rootViewController: waiverVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func handleLogOut() {
        
        do
        {
            try Auth.auth().signOut()
            presentLoginVC()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func animatePanel(shouldExpand: Bool,menuOption: MenuOption?) {
        
        if shouldExpand {
//         show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 780
            }, completion: nil)
            
            //disable HomeVC() and close menu with tap gesture
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleCenterControllerVCTapped(_:)))
           centerController.view.addGestureRecognizer(tap)
            
        } else {

            centerController.view.gestureRecognizers?.removeAll()
            
//            hide menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        animateStatusBar()
    }
    
    @objc func handleCenterControllerVCTapped(_ sender: UITapGestureRecognizer? = nil) {
        
        handleMenuToggle(forMenuOption: menuOption)
    }
    
    func didSelectMenuOption(menuOption: MenuOption){
        switch menuOption{
        case .Submit:
            print("Submit email")
        case .Waivers:
            presentWaiverVC()
        case .Reservations:
            let addReservationVC = AddReservationVC()
            present(UINavigationController(rootViewController: addReservationVC), animated: true, completion: nil)
        case .LogOut:
           handleLogOut()
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
      }, completion: nil)
    }
    
    func addShadow() {
        
        let viewLayer = centerController.view.layer
        
        viewLayer.shadowPath = UIBezierPath(roundedRect: centerController.view.bounds, cornerRadius: viewLayer.cornerRadius).cgPath
        viewLayer.shadowColor = UIColor.black.cgColor
        viewLayer.shadowOpacity = 0.4
        viewLayer.shadowOffset = CGSize(width: -10, height: 0)
        viewLayer.shadowRadius = 5
        viewLayer.masksToBounds = false
    }
}

extension ContainerVC: HomeVcDelegate {
   
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
        configureMenuVC()
    }
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
        
    
    }
}

