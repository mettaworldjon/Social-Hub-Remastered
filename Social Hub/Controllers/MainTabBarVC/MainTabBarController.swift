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
    
    // Fetch Current User - Method
    // Places into Global User for one time fetching
    // Places User into appropriate controller
    fileprivate func fetchCurrentUser(_ uid: String) {
        Firestore.firestore().getUserFromUID(uid: uid) { (user) in
            guard let user = user else { return }
            self.profile.setUser(user: user)
        }
    }
    
    // Add Title into Tab Bar
    fileprivate func configTab( _ image:UIImage,_ nav:UINavigationController, _ title:String) {
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
    }
    
    convenience init(uid:String) {
        self.init()
        fetchCurrentUser(uid)
        viewControllers = [profilePage,profilePage1] // Tab Bars
    }
    
    
    
    convenience init(user:User) {
        self.init()
        self.profile.setUser(user: user)
        viewControllers = [profilePage,profilePage1]
    }
    
    
    fileprivate let profile = ProfileController(UICollectionViewLayout.getLayout(.vertical))
    fileprivate lazy var profilePage = UINavigationController(rootViewController: self.profile)
    fileprivate let profilePage1 = UINavigationController(rootViewController: ProfileController(UICollectionViewLayout.getLayout(.vertical)))
    
    
    
}
