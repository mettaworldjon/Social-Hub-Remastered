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
    
    // Set User - Method
    func setUser( _ uid:String) {
        let profile = ProfileController(UICollectionViewLayout.getLayout(.vertical))
        let profilePage = UINavigationController(rootViewController: profile)
        self.configTab(#imageLiteral(resourceName: "profile-unselected"), profilePage, "Profile")
        self.viewControllers = [profilePage]
        Firestore.firestore().getUserFromUID(uid: uid) { (user)  in
            guard let user = user else { return }
            profile.setUser(user: user)
        }
    }
    
    // Set User - Method
    func setUser( _ user:User) {
        self.setUser(user.uid)
    }
    
    // Init - With User
    convenience init(uid:String) {
        self.init()
        self.setUser(uid)
    }
    
    // Init - With User
    convenience init(user:User) {
        self.init(uid: user.uid)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Add Title into Tab Bar
    fileprivate func configTab( _ image:UIImage,_ nav:UINavigationController, _ title:String) {
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
    }
    
    
    
}
