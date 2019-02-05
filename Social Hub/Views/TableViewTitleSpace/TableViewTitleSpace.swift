//
//  TableViewTitleSpace.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 2/4/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class TableViewTitleSpace: UIView {
    
    private let title:UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 12)
        title.textColor = UIColor.Theme.gray_79
        return title
    }()
    
    convenience init(_ title:String) {
        self.init(frame: .zero)
        self.title.text = title
        self.addSubview(self.title)
        self.backgroundColor = UIColor.Theme.gray_19
        NSLayoutConstraint.activate([
            self.title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
    }
    
}
