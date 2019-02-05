//
//  AccountTableViewCell.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 2/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    private let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.layer.cornerRadius = 25
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    private let fullName:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        name.textColor = UIColor.Theme.textColor
        return name
    }()
    
    private let username:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 14)
        name.textColor = UIColor.Theme.gray_79
        return name
    }()
    
    private let title:UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 16)
        name.textColor = UIColor.Theme.textColor
        return name
    }()
    
    private let detail:UILabel = {
        let detail = UILabel()
        detail.font = UIFont.systemFont(ofSize: 14)
        detail.textColor = UIColor.Theme.gray_79
        return detail
    }()
    
    private let rightArrow:UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 7.41, height: 12)
        image.contentMode = .center
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    enum DetailedView {
        case profile
        case selection
    }
    
    func setCell(user:User?,typeOfView:DetailedView, detail:String = "Edit", title:String = "", image:UIImage? = UIImage(named: "small-right")) {
        guard let user = user else { return }
        if typeOfView == .profile {
            UIViewController.loadProfileImage(user, self.profileImage, nil)
            self.profileImage.backgroundColor = .darkGray
            self.addSubview(profileImage)
            NSLayoutConstraint.activate([
                profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
            fullName.text = user.fullname
            username.text = "@\(user.username)"
            let stackView = UIStackView(arrangedSubviews: [fullName,username])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            self.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
                stackView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
                ])
            
            self.detail.text = detail
            self.rightArrow.image = image
            let stackView2 = UIStackView(arrangedSubviews: [self.detail,rightArrow])
            stackView2.spacing = 10
            stackView2.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(stackView2)
            NSLayoutConstraint.activate([
                stackView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                stackView2.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
        } else {
            self.title.text = title
            self.addSubview(self.title)
            NSLayoutConstraint.activate([
                self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
            self.detail.text = detail
            self.rightArrow.image = image
            let stackView2 = UIStackView(arrangedSubviews: [self.detail,rightArrow])
            stackView2.spacing = 10
            stackView2.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(stackView2)
            NSLayoutConstraint.activate([
                stackView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                stackView2.centerYAnchor.constraint(equalTo: self.centerYAnchor)
                ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    


}
