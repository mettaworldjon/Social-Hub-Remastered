//
//  User.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/25/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

struct User:Codable {
    
    let uid:String
    let fullname:String
    let username:String
    let email:String
    var profileImageUrl:String
    var bio:String
    var website:String
    var profileType:String
    
    
    init(_ uid:String, _ dict:[String:Any]) {
        self.uid = uid
        self.username = dict["username"] as? String ?? ""
        self.fullname = dict["fullname"] as? String ?? ""
        self.profileImageUrl = dict["profileImageUrl"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.bio = dict["bio"] as? String ?? ""
        self.website = dict["website"] as? String ?? ""
        self.profileType = dict["profileType"] as? String ?? ""
    }
    
    init(_ uid:String, _ userName:String, _ profileImageUrl:String, _ email:String, _ fullname:String, _ bio:String = "", _ website:String = "", _ profileType:String = "Personal Blog") {
        self.uid = uid
        self.username = userName
        self.profileImageUrl = profileImageUrl
        self.email = email
        self.fullname = fullname
        self.bio = bio
        self.website = website
        self.profileType = profileType
    }
    
    func getDictionary() -> [String:Any] {
        return [
            "fullname":fullname,
            "username":username,
            "email":email,
            "profileImageUrl":profileImageUrl,
            "bio":bio,
            "website":website,
            "profileType":profileType
            ] as [String:Any]
    }
    
}
