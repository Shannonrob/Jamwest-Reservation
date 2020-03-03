//
//  SignUpVC.swift
//  Jamwest Reservation
//
//  Created by Shannon Robinson on 3/3/20.
//  Copyright © 2020 Wurllink. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    let emailTextField: UITextField = {
         
        let textfield = UITextField()
        textfield.design(placeHolder: "Email", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        textfield.keyboardType = .emailAddress
        textfield.textfieldClearButtonIcon(#imageLiteral(resourceName: "grayClearButtonExpanded "))
        return textfield
    }()
    
    let userNameTextfield: UITextField = {
         
        let textfield = UITextField()
        textfield.design(placeHolder: "Username", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        textfield.textfieldClearButtonIcon(#imageLiteral(resourceName: "grayClearButtonExpanded "))
        return textfield
    }()
    
    let passwordTextfield: UITextField = {
         
        let textfield = UITextField()
        textfield.design(placeHolder: "Password", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.isSecureTextEntry = true
        textfield.textfieldClearButtonIcon(#imageLiteral(resourceName: "grayClearButtonExpanded "))
        textfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textfield
    }()
    
    let confirmPasswordTextfield: UITextField = {
        
        let textfield = UITextField()
        textfield.design(placeHolder: "Confirm Password", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.isSecureTextEntry = true
        textfield.textfieldClearButtonIcon(#imageLiteral(resourceName: "grayClearButtonExpanded "))
        textfield.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textfield
    }()
    
    let signUpButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 374/255, green: 175/255, blue: 22/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let incorrectPasswordLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Password doesn't match"
        label.textColor = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
        label.isHidden = true
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 22)
        return label
    }()
    
    let alreadyHaveAccount: UIButton = {
    
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)]))
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

         view.backgroundColor = Constants.Design.Color.Primary.HeavyGreen
        
        configureViewComponents()
        textFieldDelegates()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 30, paddingRight: 0, width: 0, height: 50)
    }
    
    @objc func handleShowLogIn() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        
        view.endEditing(true)
        
        guard let email = emailTextField.text,
              let password = passwordTextfield.text,
              let username = userNameTextfield.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            handle error
            if let error = error {
                print("Failed to create user with error:", error.localizedDescription)
                return
            }
            
            guard let uid = user?.user.uid else { return }
            
            let dictionaryValues = ["username": username]
            let values = [uid: dictionaryValues]
            
//            save user info to dataBase and log user in
            USER_REF.updateChildValues(values) { (error, ref) in
         
                self.presenContainerVC()
            }
        }
    }
    
    @objc func formValidation() {
        
        guard
            emailTextField.hasText,
            userNameTextfield.hasText,
            passwordTextfield.hasText,
            confirmPasswordTextfield.hasText && confirmPasswordTextfield.text == passwordTextfield.text else {
                
                passwordCheck()
                signUpButton.isEnabled = false
                signUpButton.backgroundColor = UIColor(red: 374/255, green: 175/255, blue: 22/255, alpha: 1)
                return
        }
        passwordCheck()
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
    }
    
    // delete contents of textfield
       @objc func handleClearTextField(textfield: Bool) {

        if emailTextField.isFirstResponder {
               emailTextField.text?.removeAll()
        } else if userNameTextfield.isFirstResponder {
               userNameTextfield.text?.removeAll()
        } else if passwordTextfield.isFirstResponder {
            passwordTextfield.text?.removeAll()
        } else {
            confirmPasswordTextfield.text?.removeAll()
        }
      }
    
//    MARK: - Helper Functions
    
    func textFieldDelegates() {
          
        emailTextField.delegate = self
        userNameTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmPasswordTextfield.delegate = self
      }
      
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case emailTextField:
            userNameTextfield.becomeFirstResponder()
        case userNameTextfield:
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            confirmPasswordTextfield.becomeFirstResponder()
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
      
    
    func passwordCheck() {
        
        if confirmPasswordTextfield.text != passwordTextfield.text {
            incorrectPasswordLabel.isHidden = false
        } else {
            incorrectPasswordLabel.isHidden = true
        }
    }
    
    
    func presenContainerVC() {
        
        let containerVC = ContainerVC()
        let navigationController = UINavigationController(rootViewController: containerVC)
        view.addSubview(navigationController.view)
        addChild(navigationController)
        navigationController.didMove(toParent: self)
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func configureViewComponents() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,userNameTextfield,passwordTextfield,confirmPasswordTextfield,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 600, height: 320)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        view.addSubview(incorrectPasswordLabel)
        incorrectPasswordLabel.anchor(top: stackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        incorrectPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}
