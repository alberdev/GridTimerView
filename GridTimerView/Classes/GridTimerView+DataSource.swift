//
//  GridTimerView+DataSource.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 4/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

extension GridTimerView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(inGridTimerView: self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.gridTimerView(gridTimerView: self, numberOfItemsInSection: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let dataSource = dataSource, kind == UICollectionElementKindSectionHeader else {
            return UICollectionViewCell()
        }
        let cell = dataSource.gridTimerView(
            gridTimerView: self,
            collectionView: collectionView,
            cellForIndexPath: indexPath) as? GridCollectionViewCell
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        return cell == nil ? UICollectionViewCell() : cell!
    }
}
