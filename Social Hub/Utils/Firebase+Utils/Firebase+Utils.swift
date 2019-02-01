//
//  Firebase+Utils.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/25/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase

extension Firestore {
    func placeUserData(user:User, completion:@escaping (Bool) -> ()) {
        Firestore.firestore().collection("users").document(user.uid).setData(user.getDictionary()) { (error) in
            // Error Check
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(false)
                return
            }
            // ✅
            completion(true)
        }
    }
    
    func getUserFromUID(uid:String, completion:@escaping (User?) -> ()) {
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            // Error Check
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            // ✅
            if let snapshot = snapshot?.data() {
                completion(User(uid, snapshot))
            } else {
                completion(nil)
            }
        }
    }
}

extension Auth {
    func signInUser(email:String, password:String, completion:@escaping (Bool, _ user:User?) -> ()) {
        signIn(withEmail: email, password: password) { (results, error) in
            // Error Check
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(false, nil)
                return
            }
            // ✅
            if let results = results, let user = self.currentUser {
                if results.user.uid == user.uid {
                    Firestore.firestore().getUserFromUID(uid: results.user.uid, completion: { (user) in
                        if let user = user {
                            // ✅
                            completion(true, user)
                        } else {
                            completion(false, nil)
                        }
                    })
                } else {
                    completion(false, nil)
                }
            } else {
                completion(false,nil)
            }
        }
    }
    
    func createUserAccount(email:String, password:String, username:String, fullname:String, image:UIImage, completion:@escaping (Bool, _ user:User?) -> ()) {
        createUser(withEmail: email, password: password) { (results, error) in
            // Error Check
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(false, nil)
                return
            }
            if let results = results, let user = self.currentUser {
                if results.user.uid == user.uid {
                    // ✅
                    var userFinal = User(results.user.uid, username, "", email, fullname)
                    Storage.storage().uploadProfilePicture(user: userFinal, image: image, completion: { (url) in
                        userFinal.profileImageUrl = url
                        Firestore.firestore().placeUserData(user: userFinal, completion: { (value) in
                            if value {
                                completion(true, userFinal)
                            } else {
                                completion(false, nil)
                            }
                        })
                    })
                }
            } else {
                completion(false, nil)
                return
            }
            
        }
    }
}

extension Storage {
    
    func defaultImage() -> String {
        return "https://firebasestorage.googleapis.com/v0/b/social-hub-main.appspot.com/o/profile-images%2FFF9E31F5-0CD1-4DCD-A690-F2D43038F7D2?alt=media&token=79067ac8-f553-4e73-8a6d-970cbb63fcc6"
    }
    
    func uploadProfilePicture(user:User, image:UIImage, completion:@escaping (String) -> ()) {
        let fileName = NSUUID().uuidString
        let ref = reference().child("profile-images").child(fileName)
        guard let imageData = image.jpegData(compressionQuality: 0.7) else { completion(defaultImage()); return }
        ref.putData(imageData, metadata: nil) { (meta, error) in
            // Error Check
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(self.defaultImage())
                return
            }
            // ✅
            ref.downloadURL(completion: { (url, error) in
                // Error Check
                if let error = error {
                    debugPrint(error.localizedDescription)
                    completion(self.defaultImage())
                    return
                }
                // ✅
                if let url = url {
                    completion(url.absoluteString)
                } else {
                    completion(self.defaultImage())
                }
            })
        }
    }
}
