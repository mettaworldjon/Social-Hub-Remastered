//
//  BreakLine.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/27/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class BreakLine: UIView {
    
    convenience init(_ height:CGFloat,_ color:UIColor) {
        self.init(frame: .zero)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.backgroundColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame:.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
