//
//  GridTimerView+Delegate.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 4/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

extension GridTimerView: UICollectionViewDelegateFlowLayout {
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? GridItemViewCell,
            let viewModel = cell.viewModel
            else { return }
        
        delegate?.gridTimerView(gridTimerView: self, didSelectRowAtItemIndex: viewModel.item, inRowIndex: viewModel.row)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.collectionView {
            
            backScrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y), animated: false)
            
            // Init grid refresh action
            if
                let isRefreshing = refresher?.isRefreshing,
                scrollView.contentOffset.y < scrollRefreshLimitY,
                !isRefreshing && firstScroll {
                refresher?.beginRefreshing()
                refresher?.sendActions(for: .valueChanged)
            } else if scrollView.contentOffset.y > -50 {
                refresher?.endRefreshing()
            }
            
            // Update rule offset
            ruleView.updateContentOffset(x: scrollView.contentOffset.x)
            
            // Update visible cells with offset
            for cell in collectionView.visibleCells as! [GridItemViewCell] {
                cell.collectionView.contentOffset.x = scrollView.contentOffset.x
                cell.updateHighlightedItems()
            }
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        firstScroll = true
    }
}

extension GridTimerView: GridItemViewCellDelegate {
    
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, didHighlightAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int) {
        delegate?.gridTimerView(gridTimerView: self, didHighlightAtItemIndex: itemIndex, inRowIndex: rowIndex)
    }
}
