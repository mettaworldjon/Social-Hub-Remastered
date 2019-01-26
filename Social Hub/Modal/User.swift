//
//  User.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/25/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

struct User {
    
    let uid:String
    let username:String
    let profileImageUrl:String
    let email:String
    
    init(_ uid:String, _ dict:[String:Any]) {
        self.uid = uid
        self.username = dict["username"] as? String ?? ""
        self.profileImageUrl = dict["profileImageUrl"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
    }
    
    init(_ uid:String, _ userName:String, _ profileImageUrl:String, _ email:String ) {
        self.uid = uid
        self.username = userName
        self.profileImageUrl = profileImageUrl
        self.email = email
    }
    
    func getDictionary() -> [String:Any] {
        return [
            "username":username,
            "profileImageUrl":profileImageUrl,
            "email":email
            ] as [String:Any]
    }
    
}
