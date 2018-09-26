//
//  GridTimerView+Delegate.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 4/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

extension GridTimerView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 54.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Select event
    }
}

extension GridTimerView: UIScrollViewDelegate {
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        firstScroll = true
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        backScrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y), animated: false)
        if
            let isRefreshing = refresher?.isRefreshing,
            scrollView.contentOffset.y < scrollRefreshLimitY,
            !isRefreshing && firstScroll {
            refresher?.beginRefreshing()
            refresher?.sendActions(for: .valueChanged)
        } else if scrollView.contentOffset.y > -50 {
            refresher?.endRefreshing()
        }
        
        ruleView.updateContentOffset(x: scrollView.contentOffset.x)
        updateHighlightedItems()
    }
}

extension GridTimerView: GridItemViewDelegate {
    
    func gridItemView(gridItemView: GridItemView, didSelect selected: Bool) {
        if let indexPath = gridItemView.indexPath {
            delegate?.gridTimerView(gridTimerView: self, didSelectRowAtIndex: indexPath.section)
        }
    }
}
