//
//  UICollectionView+.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.10.
//

import UIKit

extension UICollectionView {
    func register(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
    }
}
