//
//  UICollectionView+Tools.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 28/9/18.
//

import UIKit

extension UICollectionView {
    
    func registerInClass(_ className: AnyClass, forCellWithReuseIdentifier identifier: String) {
        self.register(UINib(nibName: identifier, bundle: Bundle(for: className)), forCellWithReuseIdentifier: identifier)
    }
}
