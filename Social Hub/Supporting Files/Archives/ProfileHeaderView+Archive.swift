//
//  ProfileHeaderCell.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/27/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class ProfileHeaderView_Archive: UICollectionViewCell {
    
    // Profile - Photo
    let profileIcon:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Profile-Launch-Photo-Icon").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btn.layer.cornerRadius = 50
        btn.clipsToBounds = true
        return btn
    }()
    
    // Profile - Message
    let messageButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "message-button").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        return btn
    }()
    
    // Profile - Menu
    let menuButton:UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "menu-button").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        return btn
    }()
    
    // Profile - Username
    let username:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Johnny Swift"
        name.textColor = UIColor.Theme.textColor
        name.font = .systemFont(ofSize: 24, weight: .bold)
        return name
    }()
    
    // Profile - Bio
    let bio:UILabel = {
        let bio = UILabel()
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.text = "iOS Engineer Swift 4.x \n and Beyond"
        bio.textColor = UIColor.Theme.gray_79
        bio.numberOfLines = 0
        bio.textAlignment = .center
        return bio
    }()
    
    // Profile - Post Stats
    let postStats:UILabel = {
        let stat = UILabel()
        stat.translatesAutoresizingMaskIntoConstraints = false
        stat.textAlignment = .center
        stat.numberOfLines = 0
        let atti = NSMutableAttributedString(string: "11K\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.textColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)])
        atti.append(NSAttributedString(string: "Post", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.gray_79,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]))
        stat.attributedText = atti
        return stat
    }()
    
    let followerStats:UILabel = {
        let stat = UILabel()
        stat.translatesAutoresizingMaskIntoConstraints = false
        stat.textAlignment = .center
        stat.numberOfLines = 0
        let atti = NSMutableAttributedString(string: "59M\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.textColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)])
        atti.append(NSAttributedString(string: "Followers", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.gray_79,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]))
        stat.attributedText = atti
        return stat
    }()
    
    let followingStats:UILabel = {
        let stat = UILabel()
        stat.translatesAutoresizingMaskIntoConstraints = false
        stat.textAlignment = .center
        stat.numberOfLines = 0
        let atti = NSMutableAttributedString(string: "43\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.textColor,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)])
        atti.append(NSAttributedString(string: "Following", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.Theme.gray_79,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]))
        stat.attributedText = atti
        return stat
    }()
    
    
    // Entry Point //
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    // Layout - Configurations
    fileprivate func configureUI() {
        // Profile Icon - Layout
        self.addSubview(profileIcon)
        NSLayoutConstraint.activate([
            profileIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)
            ])
        // Message Icon - Layout
        self.addSubview(messageButton)
        NSLayoutConstraint.activate([
            messageButton.centerYAnchor.constraint(equalTo: profileIcon.centerYAnchor),
            messageButton.trailingAnchor.constraint(equalTo: profileIcon.leadingAnchor, constant: -30)
            ])
        // Menu Icon - Layout
        self.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: profileIcon.centerYAnchor),
            menuButton.leadingAnchor.constraint(equalTo: profileIcon.trailingAnchor, constant: 30)
            ])
        // Username - Layout
        self.addSubview(username)
        NSLayoutConstraint.activate([
            username.centerXAnchor.constraint(equalTo: profileIcon.centerXAnchor),
            username.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 10)
            ])
        // User Bio - Layout
        self.addSubview(bio)
        NSLayoutConstraint.activate([
            bio.centerXAnchor.constraint(equalTo: username.centerXAnchor),
            bio.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 6)
            ])
        // Break Line - Layout
        let br = BreakLine()
        self.addSubview(br)
        NSLayoutConstraint.activate([
            br.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            br.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            br.topAnchor.constraint(equalTo: bio.bottomAnchor, constant: 15)
            ])
        // Stats Stackview - Layout
//        let stackView = UIStackView(arrangedSubviews: [postStats,followerStats,followingStats])
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: br.bottomAnchor, constant: 15),
//            stackView.leadingAnchor.constraint(equalTo: messageButton.leadingAnchor, constant: -30),
//            stackView.trailingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 30)
//            ])
        // Post Stat - Layout
        self.addSubview(postStats)
        NSLayoutConstraint.activate([
            postStats.centerXAnchor.constraint(equalTo: messageButton.centerXAnchor),
            postStats.topAnchor.constraint(equalTo: br.bottomAnchor, constant: 15)
            ])
        // Followers Stat - Layout
        self.addSubview(followerStats)
        NSLayoutConstraint.activate([
            followerStats.centerXAnchor.constraint(equalTo: profileIcon.centerXAnchor),
            followerStats.topAnchor.constraint(equalTo: br.bottomAnchor, constant: 15)
            ])
        // Followering Stat - Layout
        self.addSubview(followingStats)
        NSLayoutConstraint.activate([
            followingStats.centerXAnchor.constraint(equalTo: menuButton.centerXAnchor),
            followingStats.topAnchor.constraint(equalTo: br.bottomAnchor, constant: 15)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
