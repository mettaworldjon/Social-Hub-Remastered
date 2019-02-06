//
//  ProfileHeaderCell.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/28/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase

class ProfileHeaderCell: UICollectionViewCell {
    
    // User Package
    var user:User? {
        didSet {
            handleUserInsertion()
        }
    }
    
    // Handle User Insertion
    fileprivate func handleUserInsertion() {
        guard let user = self.user else { return }
        self.profileName.text = user.fullname
        self.profileType.text = user.profileType
        self.profileBio.text = user.bio
        self.profileWebsite.text = user.website
//        UIViewController.loadProfileImage(user, self.profileImage, nil)
        UIViewController.loadProfileImage(user, self.profileImage, nil) {
            UIView.animate(withDuration: 1, animations: {
                self.profileImage.alpha = 1
                self.profileName.alpha = 1
                self.profileType.alpha = 1
                self.profileBio.alpha = 1
                self.profileWebsite.alpha = 1
            })
        }
    }
    
    // Profile - Image
    fileprivate let profileImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 70).isActive = true
        image.widthAnchor.constraint(equalToConstant: 70).isActive = true
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        image.alpha = 0
        return image
    }()
    
    // Profile - Name
    fileprivate let profileName:UILabel = {
        let name = UILabel()
        name.textColor = UIColor.Theme.textColor
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.alpha = 0
        return name
    }()
    
    // Profile - Type
    fileprivate let profileType:UILabel = {
        let name = UILabel()
        name.textColor = UIColor.Theme.gray_79
        name.font = .systemFont(ofSize: 14, weight: .regular)
        name.alpha = 0
        return name
    }()
    
    // Profile - Add Button
    fileprivate let addButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "add-button").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return btn
    }()
    
    // Profile - Message Button
    fileprivate let messageButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "message-button").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return btn
    }()
    
    // Profile - Photo Block
    fileprivate func getPhotoBlock(_ image:UIImage?, frame:CGRect, num:Int?) -> UIButton {
        let imageBtn = UIButton(type: .system)
        imageBtn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        imageBtn.frame = frame
        imageBtn.layer.cornerRadius = 6
        if let count = num {
            let atti = NSMutableAttributedString(string: "+\(count)\n", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold),
                NSAttributedString.Key.foregroundColor : UIColor.white])
            atti.append(NSAttributedString(string: "Photos", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular),
                NSAttributedString.Key.foregroundColor : UIColor.white]))
            imageBtn.setAttributedTitle(atti, for: .normal)
            imageBtn.titleLabel?.textAlignment = .center
            imageBtn.backgroundColor = UIColor.Theme.gray_79
            imageBtn.titleLabel?.numberOfLines = 0
            return imageBtn
        }
        return imageBtn
    }
    
    // Profile - Bio
    let profileBio:UILabel = {
        let bio = UILabel()
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.textColor = UIColor.Theme.textColor
        bio.font = .systemFont(ofSize: 16, weight: .regular)
        bio.numberOfLines = 0
        bio.alpha = 0
        return bio
    }()
    
    // Profile - Website
    let profileWebsite:UILabel = {
        let bio = UILabel()
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.textColor = UIColor.Theme.baseColor
        bio.font = .systemFont(ofSize: 16, weight: .bold)
        bio.alpha = 0
        return bio
    }()
    
    // Profile - Stat Method
    fileprivate func statMethod(_ count:Int, _ type:String) -> UIButton{
        let btn = UIButton(type: .system)
        let atti = NSMutableAttributedString(string: "\(count)K\n", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor.Theme.textColor])
        atti.append(NSAttributedString(string: "Post", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular),
            NSAttributedString.Key.foregroundColor : UIColor.Theme.gray_79]))
        btn.setAttributedTitle(atti, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.numberOfLines = 0
        return btn
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureLayout()
    }
    
    fileprivate func configureLayout() {
        // Profile Image - Layout
        self.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
            ])
        // Name & Type - Layout
        let stackView = UIStackView(arrangedSubviews: [profileName,profileType])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 14)
            ])
        // Add Button - Layout
        self.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            addButton.heightAnchor.constraint(equalToConstant: 70)
            ])
        // Message Button - Layout
        self.addSubview(messageButton)
        NSLayoutConstraint.activate([
            messageButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            messageButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            ])
        // Photo Stack - Layout
        let one = getPhotoBlock(#imageLiteral(resourceName: "placeholder-image"), frame: CGRect(x: 0, y: 0, width: 80, height: 70), num: nil)
        let two = getPhotoBlock(#imageLiteral(resourceName: "placeholder-image"), frame: CGRect(x: 0, y: 0, width: 80, height: 70), num: nil)
        let three = getPhotoBlock(#imageLiteral(resourceName: "placeholder-image"), frame: CGRect(x: 0, y: 0, width: 80, height: 70), num: nil)
        let all = getPhotoBlock(nil, frame: CGRect(x: 0, y: 0, width: 75, height: 70), num: 480)
        let photoStack = UIStackView(arrangedSubviews: [one,two,three,all])
        photoStack.distribution = .fillEqually
        photoStack.spacing = 10
        photoStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(photoStack)
        NSLayoutConstraint.activate([
            photoStack.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            photoStack.trailingAnchor.constraint(equalTo: addButton.trailingAnchor),
            photoStack.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 14)
            ])
        // Profile Bio - Layout
        self.addSubview(profileBio)
        NSLayoutConstraint.activate([
            profileBio.leadingAnchor.constraint(equalTo: photoStack.leadingAnchor),
            profileBio.trailingAnchor.constraint(equalTo: photoStack.trailingAnchor),
            profileBio.topAnchor.constraint(equalTo: photoStack.bottomAnchor, constant: 14)
            ])
        // Website - Layout
        profileWebsite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openWebPage)))
        profileWebsite.isUserInteractionEnabled = true
        self.addSubview(profileWebsite)
        NSLayoutConstraint.activate([
            profileWebsite.topAnchor.constraint(equalTo: profileBio.bottomAnchor, constant: 15),
            profileWebsite.leadingAnchor.constraint(equalTo: profileBio.leadingAnchor),
            profileWebsite.trailingAnchor.constraint(equalTo: profileBio.trailingAnchor)
            ])
        // Line Break
        let line = BreakLine(1,UIColor.Theme.gray_39)
        self.addSubview(line)
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: photoStack.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: photoStack.trailingAnchor),
            line.topAnchor.constraint(equalTo: profileWebsite.bottomAnchor, constant: 15)
            ])
        // Stat StackView - Layout
        let post = statMethod(11, "Posts")
        let followers = statMethod(58, "Posts")
        let following = statMethod(43, "Posts")
        let statStackView = UIStackView(arrangedSubviews: [post,followers,following])
        statStackView.translatesAutoresizingMaskIntoConstraints = false
        statStackView.distribution = .fillEqually
        self.addSubview(statStackView)
        NSLayoutConstraint.activate([
            statStackView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 15),
            statStackView.leadingAnchor.constraint(equalTo: line.leadingAnchor, constant: 0),
            statStackView.trailingAnchor.constraint(equalTo: line.trailingAnchor, constant: 0)
            ])
        // Line Break
        let bottomLine = BreakLine(10,UIColor.Theme.gray_19)
        self.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomLine.topAnchor.constraint(equalTo: statStackView.bottomAnchor, constant: 15)
            ])
    }
    
    @objc fileprivate func openWebPage() {
        print("opening")
//        guard let urlText = self.profileWebsite.text else { return }
        guard let url = URL(string: "https://www.google.com") else { return }
        print("URL MADE")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
