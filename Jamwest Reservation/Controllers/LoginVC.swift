//
//  LoginVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var window: UIWindow?
    var centerController: UIViewController!
    
//    MARK: - Textfields
    
   let emailTextField: UITextField = {
      
    let textfield = UITextField()
    textfield.design(placeHolder: "Email", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
    textfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
    textfield.keyboardType = .emailAddress
    textfield.textfieldClearButtonIcon(#imageLiteral(resourceName: "grayClearButtonExpanded "))
    return textfield
   }()
    
   let passwordTextField: UITextField = {
       
    let textfield = UITextField()
    textfield.design(placeHolder: "Password", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
    textfield.isSecureTextEntry = true
    textfield.textfieldClearButtonIcon(#imageLiteral(resourceName: "grayClearButtonExpanded "))
    textfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
    return textfield
    }()
    
//    MARK: - Buttons
    
    let loginButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 374/255, green: 175/255, blue: 22/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let incorrectPasswordLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Incorrect email or password"
        label.textColor = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
        label.isHidden = true
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 22)
        return label
    }()
    
    let dontHaveAccountButton: UIButton = {
      
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
//    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Design.Color.Primary.HeavyGreen
        navigationController?.navigationBar.isHidden = true
        configureViewComponents()
        
        textFieldDelegates()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
      
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 30, paddingRight: 0, width: 0, height: 50)
    }
   
//    MARK: - Handlers
    
    @objc func handleShowSignUp() {
       
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleLogin() {
        
        view.endEditing(true)
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
//            handle error
            if let error = error {
                print("Unable to sign user in with error", error.localizedDescription)
                self.incorrectPasswordLabel.isHidden = false
                return
            }
//            handle success
            self.presenContainerVC()
        }
    }
    
    @objc func formValidation() {
           guard
           emailTextField.hasText,
           passwordTextField.hasText else {
           loginButton.isEnabled = false
           incorrectPasswordLabel.isHidden = true
           loginButton.backgroundColor = UIColor(red: 374/255, green: 175/255, blue: 22/255, alpha: 1)
           return
           }
           loginButton.isEnabled = true
           loginButton.backgroundColor = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
       }
    
    // delete contents of textfield
    @objc func handleClearTextField(textfield: Bool) {
       
        if emailTextField.isFirstResponder {
            emailTextField.text?.removeAll()
        } else {
            passwordTextField.text?.removeAll()
        }
   }
    
//    MARK: - Helper Functions
    
    func textFieldDelegates() {
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

       switch textField {
           
       case emailTextField:
       passwordTextField.becomeFirstResponder()
       default:
       textField.resignFirstResponder()
       }
       return false
   }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // add gesture to clear button icon
        let clearTextfieldGesture = UITapGestureRecognizer(target: self, action: #selector(handleClearTextField))
        clearTextfieldGesture.numberOfTapsRequired = 1
        textField.rightView?.addGestureRecognizer(clearTextfieldGesture)
    }
    
    func configureViewComponents() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 180, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 600, height: 180)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(incorrectPasswordLabel)
        incorrectPasswordLabel.anchor(top: stackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        incorrectPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func presenContainerVC() {
        
        let containerVC = ContainerVC()
        let navigationController = UINavigationController(rootViewController: containerVC)
        view.addSubview(navigationController.view)
        addChild(navigationController)
        navigationController.didMove(toParent: self)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
