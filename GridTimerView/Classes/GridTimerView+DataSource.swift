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
        return dataSource?.numberOfRows(inGridTimerView: self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.gridTimerView(gridTimerView: self, numberOfItemsAtRowIndex: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard
            let dataSource = dataSource,
            kind == UICollectionElementKindSectionHeader,
            let customCellType = customCellType,
            let reusableCell = dequeReusableView(withType: customCellType.self, forRowIndex: indexPath.section)
            else {
                fatalError("Custom item view register is needed! See example: gridTimerView.register(type: YouCustomItemView.self)\n\n")
//                let reusableCell = dequeReusableView(withType: GridItemView.self, forRowIndex: indexPath.section)
//                return reusableCell == nil ? UICollectionViewCell() : reusableCell!
        }
        
        let cell = dataSource.gridTimerView(gridTimerView: self, setupView: reusableCell, forItemIndex: indexPath.item, inRowIndex: indexPath.section)
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        return cell == nil ? UICollectionViewCell() : cell!
    }
}

extension GridTimerView: CustomCollectionViewLayoutDataSource {
    
    func timeDurationForIndexPath(indexPath: IndexPath) -> Double? {
        return dataSource?.gridTimerView(gridTimerView: self, timeDurationForItemIndex: indexPath.item, inRowIndex: indexPath.section)
    }
    
    func cellHeaderHeight() -> CGFloat? {
        return dataSource?.heightForRow(inGridTimerView: self)
    }
    
    func cellItemHeight() -> CGFloat? {
        return dataSource?.heightForTimelineRow(inGridTimerView: self)
    }
}
