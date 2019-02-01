//
//  Photo+Utils.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/25/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import YPImagePicker

extension YPImagePicker {
    func handleSinglePhoto(complete: @escaping (UIImage) -> ()) {
        self.didFinishPicking { [unowned self] items, cancelled in
            if cancelled {
                self.dismiss(animated: true, completion: nil)
            }
            
            if let photo = items.singlePhoto {
                if let editPhoto = photo.modifiedImage {
                    complete(editPhoto.withRenderingMode(.alwaysOriginal))
                    self.dismiss(animated: true, completion: nil)
                } else {
                    complete(photo.image.withRenderingMode(.alwaysOriginal))
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}


extension YPImagePickerConfiguration {
    mutating func singlePhotoConfig() {
        self.screens = [.library,.photo]
        self.library.maxNumberOfItems = 0
        self.startOnScreen = .library
        self.shouldSaveNewPicturesToAlbum = false
    }
}
