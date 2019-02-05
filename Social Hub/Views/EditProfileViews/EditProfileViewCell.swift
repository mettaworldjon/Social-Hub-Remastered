//
//  EditProfileViewCell.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 2/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import Imaginary

class EditProfileViewCell: UITableViewCell {
    
    enum EditProfileType:String {
        case profileImageOnly
        case name = "Name"
        case username = "Username"
        case website = "Website"
        case bio = "Bio"
        case email = "Email"
        case phone = "Phone"
        case gender = "Gender"
        case type
    }
    
    func setUser(user:User?, type:EditProfileType) {
        guard let user = user else { return }
        if type == .profileImageOnly {
            setUpProfileImage(user: user)
        } else {
            setUpField(user: user, type: type)
        }
    }
    
    private let profileImage:UIImageView = {
        let btn = UIImageView()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.image = UIImage(named: "100px")?.withRenderingMode(.alwaysOriginal)
        btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.layer.cornerRadius = 50
        btn.clipsToBounds = true
        return btn
    }()
    
    private let cameraButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "32px Icon Button Photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        return btn
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.Theme.gray_79
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let textField:UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.Theme.gray_79
        return label
    }()
    
    private let bioTextField:KMPlaceholderTextView = {
        let label = KMPlaceholderTextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isScrollEnabled = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.Theme.gray_79
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    fileprivate func setUpField(user:User, type:EditProfileType) {
        label.text = type.rawValue
        label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1)
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        if type == .bio{
            bioTextField.placeholder = user.bio
            self.addSubview(bioTextField)
            NSLayoutConstraint.activate([
                bioTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                bioTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                bioTextField.widthAnchor.constraint(equalToConstant: 265),
                bioTextField.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 10)
                ])
            let line = UIView()
            line.backgroundColor = UIColor(red:0.91, green:0.92, blue:0.92, alpha:1.00)
            line.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(line)
            NSLayoutConstraint.activate([
                line.trailingAnchor.constraint(equalTo: bioTextField.trailingAnchor),
                line.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                line.heightAnchor.constraint(equalToConstant: 1),
                line.widthAnchor.constraint(equalToConstant: 260)
                ])
        } else {
            textField.attributedPlaceholder = NSAttributedString(string: userField(user: user, type: type), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor:UIColor.Theme.gray_79])
            self.addSubview(textField)
            NSLayoutConstraint.activate([
                textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                textField.widthAnchor.constraint(equalToConstant: 260),
                textField.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 10)
                ])
            let line = UIView()
            line.backgroundColor = UIColor(red:0.91, green:0.92, blue:0.92, alpha:1.00)
            line.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(line)
            NSLayoutConstraint.activate([
                line.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                line.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                line.heightAnchor.constraint(equalToConstant: 1),
                line.widthAnchor.constraint(equalTo: textField.widthAnchor)
                ])
        }
    }
    
    func userField(user:User, type:EditProfileType) -> String {
        switch type {
        case .name:
            return user.fullname
        case .profileImageOnly:
            return user.profileImageUrl
        case .username:
            return user.username
        case .website:
            return user.website
        case .bio:
            return user.bio
        case .email:
            return user.email
        case .phone:
            return "334-322-4705"
        case .gender:
            return "Male"
        case .type:
            return user.profileType
        }
    }
    
    fileprivate func setUpProfileImage(user:User) {
        UIViewController.loadProfileImage(user, self.profileImage, nil)
        self.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        self.addSubview(cameraButton)
        NSLayoutConstraint.activate([
            cameraButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor)
            ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
