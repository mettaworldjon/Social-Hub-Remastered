//
//  SignUpController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/25/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import YPImagePicker
import Firebase

class SignUpController: UIViewController, UITextFieldDelegate {
    
    // Profile Button
    fileprivate let profileBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Profile-Launch-Photo-Icon").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return btn
    }()
    let photoIcon = UIButton(type: .system)
    
    // Register Stack
    fileprivate let registerStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let terms = UILabel()
    
    // Register Info
    fileprivate let name = TextFieldTheme("Full Name", UIColor.Theme.gray_19, TextfieldType.normal)
    fileprivate let email = TextFieldTheme("Email", UIColor.Theme.gray_19, TextfieldType.normal)
    fileprivate let password = TextFieldTheme("Password", UIColor.Theme.gray_19, TextfieldType.password)
    
    
    // Sign Up Btn
    fileprivate let signUpBtn = ButtonTheme("Create an Account", UIColor.Theme.baseColor, .white)
    
    // Image Picker Config
    var config = YPImagePickerConfiguration()
    lazy var imagePicker = YPImagePicker(configuration: self.config)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // Layout Views - Configuration
    fileprivate func setUpUI() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeKeyboard)))
        setUpNav()
        setUpProfileBtn()
        setUpRegisterStack()
        setUpSignUpTermsBtn()
        delegates()
        setUpImagePicker()
    }
    
    // Nav - Configuration
    fileprivate func setUpNav() {
        self.title = "Sign Up"
        let close = UIBarButtonItem(image: #imageLiteral(resourceName: "Close-X-Icon"), style: .plain, target: self, action: #selector(backToSignInController))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 10
        self.navigationItem.rightBarButtonItems = [space,close]
    }
    
    // Profile Image - Configuration
    fileprivate func setUpProfileBtn() {
        profileBtn.addTarget(self, action: #selector(launchPhotoPicker), for: .touchUpInside)
        profileBtn.layer.cornerRadius = 50
        profileBtn.clipsToBounds = true
        view.addSubview(profileBtn)
        NSLayoutConstraint.activate([
            profileBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        photoIcon.addTarget(self, action: #selector(launchPhotoPicker), for: .touchUpInside)
        photoIcon.translatesAutoresizingMaskIntoConstraints = false
        photoIcon.setImage(#imageLiteral(resourceName: "32px Icon Button").withRenderingMode(.alwaysOriginal), for: .normal)
        view.addSubview(photoIcon)
        NSLayoutConstraint.activate([
            photoIcon.heightAnchor.constraint(equalToConstant: 32),
            photoIcon.widthAnchor.constraint(equalToConstant: 32),
            photoIcon.trailingAnchor.constraint(equalTo: profileBtn.trailingAnchor),
            photoIcon.bottomAnchor.constraint(equalTo: profileBtn.bottomAnchor)
            ])
    }
    
    // Register Stack - Configuration
    fileprivate func setUpRegisterStack() {
        registerStack.addViewsToStack([name,email,password])
        registerStack.spacing = 10
        registerStack.axis = .vertical
        view.addSubview(registerStack)
        NSLayoutConstraint.activate([
            name.heightAnchor.constraint(equalToConstant: 40),
            email.heightAnchor.constraint(equalToConstant: 40),
            password.heightAnchor.constraint(equalToConstant: 40),
            registerStack.topAnchor.constraint(equalTo: profileBtn.bottomAnchor, constant: 30),
            registerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            registerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
    }
    
    // Sign Up & Terms Btn - Configuration
    fileprivate func setUpSignUpTermsBtn() {
        self.signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        self.signUpBtn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        view.addSubview(signUpBtn)
        NSLayoutConstraint.activate([
            signUpBtn.widthAnchor.constraint(equalTo: registerStack.widthAnchor),
            signUpBtn.heightAnchor.constraint(equalToConstant: 48),
            signUpBtn.topAnchor.constraint(equalTo: registerStack.bottomAnchor, constant: 15),
            signUpBtn.centerXAnchor.constraint(equalTo: registerStack.centerXAnchor)
            ])
        
        terms.translatesAutoresizingMaskIntoConstraints = false
        terms.textAlignment = .center
        terms.numberOfLines = 0
        let atti = NSMutableAttributedString(string: "By signing up, you agree to our\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor(red:0.59, green:0.62, blue:0.64, alpha:1.00),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
            ])
        atti.append(NSAttributedString(string: "Terms ", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.baseColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)
            ]))
        atti.append(NSAttributedString(string: "and ", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor(red:0.59, green:0.62, blue:0.64, alpha:1.00),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)
            ]))
        atti.append(NSAttributedString(string: "Privacy", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.baseColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold)
            ]))
        terms.attributedText = atti
        view.addSubview(terms)
        NSLayoutConstraint.activate([
            terms.centerXAnchor.constraint(equalTo: signUpBtn.centerXAnchor),
            terms.topAnchor.constraint(equalTo: signUpBtn.bottomAnchor, constant: 15),
            terms.heightAnchor.constraint(equalToConstant: 60),
            terms.widthAnchor.constraint(equalTo: signUpBtn.widthAnchor)
            ])
    }
    
    fileprivate func setUpImagePicker() {
        config.singlePhotoConfig()
    }
    
    // Delegates - Configuration
    fileprivate func delegates() {
        email.getTextField().delegate = self
        name.getTextField().delegate = self
        password.getTextField().delegate = self
    }
    
    // Handlers
    @objc fileprivate func handleSignUp() {
        let name = self.name.getText()
        let email = self.email.getText()
        let password = self.password.getText()
        guard let image = self.profileBtn.imageView?.image else { return }
        view.endEditing(true)
        self.signUpBtn.setTitle(nil, for: .normal)
        self.signUpBtn.isEnabled = false
        let loader = UIViewController.displaySpinner(onView: self.signUpBtn)
        if !name.validText() && (email.validEmail()) && (password.validPassword()) {
            Auth.auth().signUpUser(email, name, password, image) { (value) in
                if value {
                    print("You a bad man!")
                    self.signUpBtn.isEnabled = false
                    UIViewController.removeSpinner(spinner: loader)
                } else {
                    print("Try try again!")
                    self.signUpBtn.isEnabled = true
                    UIViewController.removeSpinner(spinner: loader)
                    self.signUpBtn.setTitle("Create an Account", for: .normal)
                }
            }
        } else {
            print("Invalid Something")
            self.signUpBtn.isEnabled = true
            UIViewController.removeSpinner(spinner: loader)
            self.signUpBtn.setTitle("Create an Account", for: .normal)
        }
    }
    
    fileprivate var photoChanged = false
    @objc fileprivate func launchPhotoPicker() {
        imagePicker.handleSinglePhoto { (image) in
            self.profileBtn.setImage(image, for: .normal)
            self.photoChanged = true
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc fileprivate func backToSignInController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func removeKeyboard() {
        view.endEditing(true)
    }
    
    // Modifiers - Configuration
    
    ////////////////// Text Field //////////////////
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.profileBtn.transform = CGAffineTransform(translationX: 0, y: -15)
            self.photoIcon.transform = CGAffineTransform(translationX: 0, y: -15)
            self.registerStack.transform = CGAffineTransform(translationX: 0, y: -15)
            self.signUpBtn.transform = CGAffineTransform(translationX: 0, y: -15)
            self.terms.transform = CGAffineTransform(translationX: 0, y: -20)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.profileBtn.transform = .identity
            self.photoIcon.transform = .identity
            self.registerStack.transform = .identity
            self.signUpBtn.transform = .identity
            self.terms.transform = .identity
            self.terms.transform = .identity
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    
}



