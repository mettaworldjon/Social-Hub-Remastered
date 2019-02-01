//
//  ContentCollectionController.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/27/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit

class ContentCollectionController: UICollectionViewController {
    convenience init( _ layout:UICollectionViewLayout) {
        self.init(collectionViewLayout: layout)
        collectionView.backgroundColor = .white
    }
}

extension UICollectionViewLayout {
    static func getLayout( _ scrollDirection:UICollectionView.ScrollDirection) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        return layout
    }
}
