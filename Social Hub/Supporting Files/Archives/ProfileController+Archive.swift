//
//  ProfileController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/27/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class ProfileController_Archive: ContentCollectionController, UICollectionViewDelegateFlowLayout {
    
    // Register ID's
    let header = "header"
    let post = "post"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureCollection()
    }
    
    // Nav - Configurations
    fileprivate func configureNav() {
        self.title = "Profile"
        let actionBtn = UIButton(type: .system)
        actionBtn.frame = CGRect(x: 0, y: 0, width: 95, height: 32)
        actionBtn.backgroundColor = UIColor.Theme.baseColor
        actionBtn.layer.cornerRadius = 16
        actionBtn.setTitleColor(.white, for: .normal)
        actionBtn.setTitle("FOLLOW", for: .normal)
        actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionBtn)
    }
    
    // Collection - Configurations
    fileprivate func configureCollection() {
        // Registered Cells
        self.collectionView.register(ProfileHeaderView_Archive.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header)
        self.collectionView.register(ProfilePostView_Archive.self, forCellWithReuseIdentifier: post)
        // Scrolling
        self.collectionView.alwaysBounceVertical = true
    }
    
    // Collection - Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 311)
    }
    
    // Collection - Header Dequeue
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.header, for: indexPath) as! ProfileHeaderView_Archive
        return header
    }
    
    // Collection - Size for Post
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
    
    // Collection - Number of Post
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // Collection - Post Inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    // Collection - Post Dequeue
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = collectionView.dequeueReusableCell(withReuseIdentifier: self.post, for: indexPath) as! ProfilePostView_Archive
        return post
    }
    
}



