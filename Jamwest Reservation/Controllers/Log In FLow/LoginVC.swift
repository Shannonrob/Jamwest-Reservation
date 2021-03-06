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
    textfield.keyboardType = .emailAddress
    textfield.addClearButtonIcon()
    textfield.returnKeyType = .next
    return textfield
   }()
    
   let passwordTextField: UITextField = {
       
    let textfield = UITextField()
    textfield.design(placeHolder: "Password", backgroundColor: .white, fontSize: 18, textColor: .black, borderStyle: .roundedRect, width: 0, height: 0)
    textfield.isSecureTextEntry = true
    textfield.addClearButtonIcon()
    textfield.returnKeyType = .go
    return textfield
    }()
    
//    MARK: - Buttons
    
    let loginButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin(textField:)), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
      
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor(red: 242/255, green: 125/255, blue: 15/255, alpha: 1), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
//    MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureStackViews()
        textFieldDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = nil
        passwordTextField.text = nil
    }
   
//    MARK: - Handlers
    
    @objc func handleShowSignUp() {
       
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleLogin(textField: Bool) {
        
        view.endEditing(true)
        
        // present custom error messages for empty textFields then API call if success
        switch textField {
            
        case emailTextField.hasText:
            Alert.showErrorMessage(on: self, with: "Enter a valid Email to continue")
        case passwordTextField.hasText:
            Alert.showErrorMessage(on: self, with: "Enter a valid Password to continue")
        default:
            attempLogin()
        }
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
       case passwordTextField:
        textField.resignFirstResponder()
        attempLogin()
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
    
    func configureUI () {
        
        view.backgroundColor = Color.Primary.heavyGreen
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureStackViews() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 180, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 600, height: 180)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: stackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
//    MARK: - API
    
    func attempLogin() {
        showLoadingView()
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        NetworkManager.shared.attempLogIn(withEmail: email, password: password) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(_):
                self.presenContainerVC()
            case .failure(let error):
                Alert.showAlert(on: self, with: error.rawValue)
            }
        }
    }
}

