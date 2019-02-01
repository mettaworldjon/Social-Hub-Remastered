//
//  MainTabBarController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/27/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    convenience init(uid:String) {
        self.init()
        uiDefaults()
        Firestore.firestore().getUserFromUID(uid: uid) { (user) in
            guard let user = user else { return }
            self.profile.setUser(user: user)
        }
        self.configTab(#imageLiteral(resourceName: "profile-unselected"), profilePage, "Profile")
        self.configTab(#imageLiteral(resourceName: "profile-unselected"), profilePage1, "Profile")
        viewControllers = [profilePage,profilePage1]
    }
    
    
    
    convenience init(user:User) {
        self.init()
        uiDefaults()
        self.profile.setUser(user: user)
        self.configTab(#imageLiteral(resourceName: "profile-unselected"), profilePage, "Profile")
        self.configTab(#imageLiteral(resourceName: "profile-unselected"), profilePage1, "Profile")
        viewControllers = [profilePage,profilePage1]
    }
    
    fileprivate func uiDefaults() {
        self.tabBar.barTintColor = UIColor(red:0.96, green:0.97, blue:0.96, alpha:1.00)
        self.tabBar.tintColor = UIColor(red:0.27, green:0.32, blue:0.33, alpha:1.00)
    }
    
    fileprivate let profile = ProfileController(UICollectionViewLayout.getLayout(.vertical))
    fileprivate lazy var profilePage = UINavigationController(rootViewController: self.profile)
    
    fileprivate let profilePage1 = UINavigationController(rootViewController: ProfileController(UICollectionViewLayout.getLayout(.vertical)))
    
    fileprivate func configTab( _ image:UIImage,_ nav:UINavigationController, _ title:String) {
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
    }
    
}
