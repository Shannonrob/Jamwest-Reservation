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
    
    //    MARK: - Properties
    
    let emailTextField: UITextField = {
        
        let textfield = UITextField()
        textfield.design(placeHolder: "Email", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.keyboardType = .emailAddress
        textfield.addClearButtonIcon()
        textfield.returnKeyType = .next
        return textfield
    }()
    
    let userNameTextfield: UITextField = {
        
        let textfield = UITextField()
        textfield.design(placeHolder: "Username", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.addClearButtonIcon()
        textfield.returnKeyType = .next
        return textfield
    }()
    
    let passwordTextfield: UITextField = {
        
        let textfield = UITextField()
        textfield.design(placeHolder: "Password", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.isSecureTextEntry = true
        textfield.addClearButtonIcon()
        textfield.returnKeyType = .next
        return textfield
    }()
    
    let confirmPasswordTextfield: UITextField = {
        
        let textfield = UITextField()
        textfield.design(placeHolder: "Confirm Password", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
        textfield.isSecureTextEntry = true
        textfield.addClearButtonIcon()
        textfield.returnKeyType = .go
        return textfield
    }()
    
    let signUpButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]))
        button.addTarget(self, action: #selector(handleShowLogInVC), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    //    MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureStackViewComponents()
        textFieldDelegates()
    }
    
    @objc func handleShowLogInVC() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp(textField: Bool) {
        
        view.endEditing(true)
        
        // present custom error messages for empty textFields then API call if success
        switch textField {
            
        case emailTextField.hasText:
            Alert.showErrorMessage(on: self, with: ErrorMessage.enterEmail)
        case userNameTextfield.hasText:
            Alert.showErrorMessage(on: self, with: ErrorMessage.enterUserName)
        case passwordTextfield.hasText:
            Alert.showErrorMessage(on: self, with: ErrorMessage.enterPassword)
        case confirmPasswordTextfield.hasText:
            Alert.showErrorMessage(on: self, with: ErrorMessage.confirmPassword)
        case passwordTextfield.text == confirmPasswordTextfield.text:
            Alert.showErrorMessage(on: self, with: ErrorMessage.passwordError)
        default:
            attempSignUp()
        }
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
        case confirmPasswordTextfield:
            textField.resignFirstResponder()
            attempSignUp()
        default:
            break
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // add gesture to clear button icon
        let clearTextfieldGesture = UITapGestureRecognizer(target: self, action: #selector(handleClearTextField))
        clearTextfieldGesture.numberOfTapsRequired = 1
        textField.rightView?.addGestureRecognizer(clearTextfieldGesture)
    }
    
    
    func presenContainerVC() {
        
        let containerVC = ContainerVC()
        let navigationController = UINavigationController(rootViewController: containerVC)
        view.addSubview(navigationController.view)
        addChild(navigationController)
        navigationController.didMove(toParent: self)
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func configureUI() {
        view.backgroundColor = Color.Primary.heavyGreen
    }
    
    func configureStackViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,userNameTextfield,passwordTextfield,confirmPasswordTextfield,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 600, height: 320)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: stackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //    MARK: - API Call
    
    func attempSignUp() {
        showLoadingView()
        
        guard let email = emailTextField.text,
            let password = passwordTextfield.text,
            let username = userNameTextfield.text else { return }
        
        NetworkManager.shared.createUser(withEmail: email, username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result{
            case .success(_):
                self.presenContainerVC()
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
}


