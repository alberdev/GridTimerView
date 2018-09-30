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
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfRows(inGridTimerView: self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let dataSource = dataSource,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridItemViewCell.uniqueIdentifier, for: indexPath) as? GridItemViewCell
            else {
                fatalError("Custom item view register is needed! Register your custom item view once GridTimerView is initializated\n")
        }
        
        // TODO: Increase performance
        let view = dataSource.gridTimerView(gridTimerView: self, viewForItemIndex: 0, inRowIndex: indexPath.item)
        cell.removeCustomUserView()
        cell.addCustomUserView(view: view)
        
        let viewModel = GridItemViewCell.ViewModel(
            selectedCellColor: configuration.selectedColorOnTouch,
            selectedItemColor: configuration.selectedItemColor,
            unselectedItemColor: configuration.unselectedItemColor,
            containerViewHeight: dataSource.heightForRow(inGridTimerView: self),
            collectionViewHeight: dataSource.heightForTimelineRow(inGridTimerView: self),
            item: 0,
            row: indexPath.item)
        
        cell.viewModel = viewModel
        cell.dataSource = self
        cell.delegate = self
        
        // TODO: Increase performance
        cell.collectionView.reloadData()
        
        return cell
    }
}

extension GridTimerView: CustomCollectionViewLayoutDataSource {
    
    func cellItemHeight() -> CGFloat? {
        let heightForRow = dataSource?.heightForRow(inGridTimerView: self) ?? 0
        let heightForTimelineRow = dataSource?.heightForTimelineRow(inGridTimerView: self) ?? 0
        let heightForSeparation = configuration.rowSeparation
        return heightForRow + heightForTimelineRow + heightForSeparation
    }
}

extension GridTimerView: GridItemViewCellDataSource {
    
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, numberOfItemsInRowIndex rowIndex: Int) -> Int {
        return dataSource?.gridTimerView(gridTimerView: self, numberOfItemsAtRowIndex: rowIndex) ?? 0
    }
    
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, colorForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> UIColor? {
        return dataSource?.gridTimerView(gridTimerView: self, colorForItemIndex: itemIndex, inRowIndex: rowIndex)
    }
    
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, containerViewForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> UIView? {
        return dataSource?.gridTimerView(gridTimerView: self, viewForItemIndex: itemIndex, inRowIndex: rowIndex)
    }
    
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, initDateForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date? {
        return dataSource?.gridTimerView(gridTimerView: self, startTimeForItemIndex: itemIndex, inRowIndex: rowIndex)
    }
    
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, endDateForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date? {
        return dataSource?.gridTimerView(gridTimerView: self, endTimeForItemIndex: itemIndex, inRowIndex: rowIndex)
    }
}
