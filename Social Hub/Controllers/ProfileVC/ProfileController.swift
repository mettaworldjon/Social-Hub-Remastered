//
//  ProfileController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/28/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class ProfileController: ContentCollectionController, UICollectionViewDelegateFlowLayout {
    
    // ID's
    fileprivate let head = "headID"
    fileprivate let post = "postID"
    
    // User Package
    fileprivate var user:User?
    
    // Handle User Insertion
    func setUser(user:User) {
        self.user = user
        self.navigationItem.title = "@\(user.username)"
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureCollection()
    }
    
    // Nav - Configurations
    fileprivate func configureNav() {
        let menuBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = menuBtn
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
