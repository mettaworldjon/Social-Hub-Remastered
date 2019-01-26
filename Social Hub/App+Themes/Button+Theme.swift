//
//  ButtonNormal+Theme.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/24/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

enum LayoutType {
    case textThenImage
    case imageThenText
}

class ButtonTheme: UIButton {
    
    convenience init( _ btnTitle:String) {
        self.init(btnTitle, UIColor.Theme.baseColor, .white)
    }

    convenience init( _ btnTitle:String, _ btnBackgroundColor:UIColor, _ btnTextColor:UIColor, _ btnType:LayoutType , _ btnImage:UIImage, _ frame:CGRect) {
        self.init(btnTitle, btnBackgroundColor, btnTextColor)
        self.setImage(btnImage.withRenderingMode(.alwaysOriginal), for: .normal)
        switch btnType {
        case .imageThenText:
            self.contentHorizontalAlignment = .right
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: frame.width - 120)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        case .textThenImage:
            self.contentHorizontalAlignment = .leading
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: frame.width - 85, bottom: 0, right: 0)
        }
    }
    
    

    convenience init( _ btnTitle:String, _ btnBackgroundColor:UIColor, _ textColor:UIColor) {
        self.init(type: .system)
        self.backgroundColor = btnBackgroundColor
        self.layer.cornerRadius = 6
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.setTitle(btnTitle, for: .normal)
        self.setTitleColor(textColor, for: .normal)
    }
    
}
