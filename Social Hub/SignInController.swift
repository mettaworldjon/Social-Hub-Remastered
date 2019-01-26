//
//  SignInController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/24/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class SignInController: UIViewController, UITextFieldDelegate {
    
    // Logo
    fileprivate let logo = UIImageView()
    
    // Main Title
    fileprivate let mainTitle = UILabel()
    
    // Sub Title
    fileprivate let subTitle = UILabel()
    
    // Input Fields
    fileprivate let registerStack = UIStackView()
    fileprivate let email = TextFieldTheme("Email")
    fileprivate let password = TextFieldTheme("Password", .password)
    
    // Sign In & Forgot Button
    let signInBtn = ButtonTheme("Login")
    let forgotBtn = ButtonTheme("Forgot Password")
    
    // Footer Button
    fileprivate lazy var footerBtn = ButtonTheme("Sign Up", UIColor.Theme.gray_19, UIColor.Theme.textColor, LayoutType.textThenImage, #imageLiteral(resourceName: "Button-Right-Arrow"), view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // Setup Layout
    fileprivate func setUpUI() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeKeyboard)))
        setUpLogoAndTitle()
        setUpStackViewAndButtons()
        
    }
    
    // Setup Logo and Title
    fileprivate func setUpLogoAndTitle() {
        // Logo
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = #imageLiteral(resourceName: "Logo_Register")
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logo.heightAnchor.constraint(equalToConstant: 40),
            logo.widthAnchor.constraint(equalToConstant: 40)
            ])
        
        // Main Title
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.numberOfLines = 0
        mainTitle.text = "Welcome to Social Hub"
        mainTitle.textColor = UIColor.Theme.textColor
        mainTitle.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        view.addSubview(mainTitle)
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: logo.topAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainTitle.widthAnchor.constraint(equalToConstant: 173)
            ])
        
        // Sub Title
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.numberOfLines = 0
        subTitle.text = "Where the Internet Comes to Talk \nAbout Things"
        subTitle.textColor = UIColor.Theme.textColor
        subTitle.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(subTitle)
        NSLayoutConstraint.activate([
            subTitle.leadingAnchor.constraint(equalTo: mainTitle.leadingAnchor),
            subTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 15)
            ])
    }
    
    // Setup StackView and Buttons
    fileprivate func setUpStackViewAndButtons() {
        // Register Stack
        forgotBtn.backgroundColor = .white
        forgotBtn.setTitleColor(UIColor.Theme.baseColor, for: .normal)
        forgotBtn.contentHorizontalAlignment = .left
        forgotBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        forgotBtn.translatesAutoresizingMaskIntoConstraints = false
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        registerStack.translatesAutoresizingMaskIntoConstraints = false
        email.getTextField().delegate = self
        password.getTextField().delegate = self
        registerStack.addViewsToStack([email,password])
        registerStack.axis = .vertical
        registerStack.spacing = 10
        view.addSubview(registerStack)
        view.addSubview(signInBtn)
        view.addSubview(forgotBtn)
        NSLayoutConstraint.activate([
            email.heightAnchor.constraint(equalToConstant: 40),
            password.heightAnchor.constraint(equalToConstant: 40),
            registerStack.leadingAnchor.constraint(equalTo: mainTitle.leadingAnchor),
            registerStack.trailingAnchor.constraint(equalTo: logo.trailingAnchor),
            registerStack.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 75),
            signInBtn.widthAnchor.constraint(equalTo: registerStack.widthAnchor),
            signInBtn.heightAnchor.constraint(equalToConstant: 48),
            
            signInBtn.topAnchor.constraint(equalTo: registerStack.bottomAnchor, constant: 20),
            signInBtn.centerXAnchor.constraint(equalTo: registerStack.centerXAnchor),
            forgotBtn.heightAnchor.constraint(equalToConstant: 15),
            forgotBtn.widthAnchor.constraint(equalTo: registerStack.widthAnchor),
            forgotBtn.centerXAnchor.constraint(equalTo: registerStack.centerXAnchor),
            forgotBtn.topAnchor.constraint(equalTo: signInBtn.bottomAnchor, constant: 10)
            ])
        
        // Footer Button
        footerBtn.translatesAutoresizingMaskIntoConstraints = false
        footerBtn.addTarget(self, action: #selector(launchSignUpController), for: .touchUpInside)
        view.addSubview(footerBtn)
        NSLayoutConstraint.activate([
            footerBtn.heightAnchor.constraint(equalToConstant: 48),
            footerBtn.leadingAnchor.constraint(equalTo: registerStack.leadingAnchor),
            footerBtn.trailingAnchor.constraint(equalTo: registerStack.trailingAnchor),
            footerBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
    }
    
    // Handlers
    @objc fileprivate func removeKeyboard() {
        view.endEditing(true)
    }
    
    @objc fileprivate func launchSignUpController() {
        let signUp = UINavigationController(rootViewController: SignUpController())
        self.present(signUp, animated: true, completion: nil)
    }
    
    // Modifiers
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.registerStack.transform = CGAffineTransform(translationX: 0, y: -55)
            self.signInBtn.transform = CGAffineTransform(translationX: 0, y: -55)
            self.forgotBtn.transform = CGAffineTransform(translationX: 0, y: -55)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.registerStack.transform = .identity
            self.signInBtn.transform = .identity
            self.forgotBtn.transform = .identity
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Fuck off!!")
    }
    
}

