//
//  ProfileController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/28/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase



class ProfileController: ContentCollectionController, UICollectionViewDelegateFlowLayout {
    
    // ID's
    fileprivate let head = "headID"
    fileprivate let post = "postID"
    
    // User Package
    fileprivate var user:User?
    
    // Handle User Insertion
    func setUser(user:User) {
        self.user = user
        navigationItem.title = "@\(user.username)"
        collectionView.reloadData()
    }
    
    // ActionSheet - Configuration
    lazy var actionSheet:UIAlertController = {
        let actionS = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        actionS.view.tintColor = UIColor.Theme.baseColor
        let menuAction = UIAlertAction(title: "Account Settings", style: .default, handler: { (_) in
            guard let user = self.user else { return }
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            let account = UserAccountController()
            account.title = "Account"
            account.setUser(user:user)
            self.navigationController?.pushViewController(account, animated: true)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logout = UIAlertAction(title: "Logout", style: .destructive, handler: { (_) in
            print("I'm out!")
        })
        actionS.addAction(menuAction)
        actionS.addAction(logout)
        actionS.addAction(cancel)
        return actionS
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureCollection()
        self.navigationController?.tabBarItem.image = #imageLiteral(resourceName: "profile-unselected")
        self.navigationController?.tabBarItem.title = "Profile"
        self.navigationItem.title = ""
    }
    
    // Nav - Configurations
    fileprivate func configureNav() {
        let menuBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(launchActionSheet))
        self.navigationItem.rightBarButtonItem = menuBtn
    }
    
    // ActionSheet - Method
    @objc fileprivate func launchActionSheet() {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // Collection - Configurations
    fileprivate func configureCollection() {
        // Registered Cells
        collectionView.register(ProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: head)
        collectionView.register(ProfilePostCell.self, forCellWithReuseIdentifier: post)
    }
    
    // Collection - Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 346)
    }
    
    // Collection - Header Rendering
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.head, for: indexPath) as! ProfileHeaderCell
        head.user = self.user
        return head
    }
    
    // Collection - Size for Post
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 346)
    }
    
    // Collection - Number of Post
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // Collection - Post Rendering
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = collectionView.dequeueReusableCell(withReuseIdentifier: self.post, for: indexPath)
        return post
    }
    
}
