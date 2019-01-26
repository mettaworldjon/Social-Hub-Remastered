//
//  TextField+Theme.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/24/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

enum TextfieldType {
    case password
    case normal
}

class TextFieldTheme: UIView {
    
    private let textField:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.Theme.textColor])
        return textField
    }()
    private var textFieldTrailingAnchor:NSLayoutConstraint?
    
    private let showPasswordBtn:UIButton = {
        let showPassword = UIButton(type: .system)
        showPassword.translatesAutoresizingMaskIntoConstraints = false
        showPassword.setImage(#imageLiteral(resourceName: "Show-Password-Icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return showPassword
    }()
    
    convenience init(_ placeholder:String) {
        self.init(placeholder, .normal)
    }
    
    convenience init(_ placeholder:String, _ type:TextfieldType) {
        self.init(placeholder, UIColor.Theme.gray_19, type)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.Theme.textColor])
        self.backgroundColor = backgroundColor
    }
    
    convenience init(_ placeholder:String, _ backgroundColor:UIColor, _ type:TextfieldType) {
        self.init(frame: .zero)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.Theme.textColor])
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .password:
            setupPasswordUI()
        case .normal: break
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.addSubview(textField)
        self.textField.autocapitalizationType = .none
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startEditing)))
        textFieldTrailingAnchor = textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        guard let textFieldTrailingAchor = textFieldTrailingAnchor else { return }
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textFieldTrailingAchor
            ])
    }
    
    fileprivate func setupPasswordUI() {
        self.getTextField().isSecureTextEntry = true
        self.addSubview(showPasswordBtn)
        showPasswordBtn.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        guard let textFieldTrailingAnchor = textFieldTrailingAnchor else { return }
        textFieldTrailingAnchor.constant = -35
        NSLayoutConstraint.activate([
            showPasswordBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            showPasswordBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            ])
    }
    
    func getTextField() -> UITextField {
        return self.textField
    }
    
    func getText() -> String {
        guard let text = self.textField.text else { return "" }
        return text
    }
    
    fileprivate var passwordShowing = false
    @objc fileprivate func showPassword() {
        if passwordShowing {
            self.getTextField().isSecureTextEntry = true
            passwordShowing = false
        } else {
            self.getTextField().isSecureTextEntry = false
            passwordShowing = true		
        }
    }

    @objc fileprivate func startEditing() {
        textField.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
