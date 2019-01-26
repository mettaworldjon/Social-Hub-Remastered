//
//  Firebase+Utils.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/25/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Firebase

// Authorization
extension Auth {
    func signUpUser(_ email:String, _ fullname:String, _ password:String, _ image:UIImage, completion:@escaping (Bool) -> ()) {
        self.createUser(withEmail: email, password: password) { (user, error) in
            // Error Catch
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            // Check if user is Signed In
            guard let user = user?.user else { completion(false); return }
            if self.checkIfValidUser(user.uid) {
                Storage.storage().uploadProfileImage(image, completion: { (url) in
                    let user = User(user.uid, fullname, url, email)
                    Database.database().placeUserIntoDB(user, completion: { value in
                        if value {
                            completion(true)
                        }
                    })
                })
            } else {
                print("Lol welp......")
                completion(false)
            }
        }
    }
    
    func checkIfValidUser(_ uid:String) -> Bool {
        var value = false
        guard let currentUID = self.currentUser?.uid else { return false }
        if currentUID == uid { value = true }
        return value
    }
}

extension Database {
    func placeUserIntoDB(_ user:User, completion:@escaping (Bool) -> ()) {
        let ref = self.reference().child("users").child(user.uid)
        ref.updateChildValues(user.getDictionary()) { (error, _) in
            // Error Check
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }
}

extension Storage {
    func uploadProfileImage(_ image:UIImage, completion:@escaping (String) -> ()) {
        let ref = self.reference().child("profile-images").child(NSUUID().uuidString)
        guard let image = image.jpegData(compressionQuality: 0.6) else { completion(defaultProfileUrl()); return }
        ref.putData(image, metadata: nil) { (storageSpot, error) in
            if let _ = error {
                completion(self.defaultProfileUrl())
                return
            }
            ref.downloadURL(completion: { (url, error) in
                if let _ = error {
                    completion(self.defaultProfileUrl())
                    return
                }
                guard let url = url?.absoluteString else { completion(self.defaultProfileUrl()); return }
                completion(url)
            })
        }
    }
    
    func defaultProfileUrl() -> String {
        return "https://firebasestorage.googleapis.com/v0/b/social-hub-main.appspot.com/o/profile-images%2FA2E158D2-2B0A-41B7-BE07-2DE768FCF2DB?alt=media&token=a0e74297-ab39-4ff5-9785-01021789b38c"
    }
}

