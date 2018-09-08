//
//  CustomCollectionViewLayout.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 5/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

protocol CustomCollectionViewLayoutDataSource: class {
    func timeDurationForIndexPath(indexPath: IndexPath) -> Int?
    func cellHeaderHeight() -> CGFloat?
    func cellItemHeight() -> CGFloat?
}

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: CustomCollectionViewLayoutDataSource?
    
    var cellItemHeight: CGFloat = 8.0
    var cellHeaderHeight: CGFloat = 66.0
    
    private var cellItemsAttributes = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    private var cellHeadersAttributes = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    private var ruleWidth = 96.05
    private var contentSize = CGSize(width: 0, height: 0)
    private var screenSize = UIScreen.main.bounds.size
    private var firstLoad = false
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func prepare() {
        
        guard let collectionView = collectionView, !firstLoad else { return }
        
        firstLoad = true
        cellItemHeight = dataSource?.cellItemHeight() ?? cellItemHeight
        cellHeaderHeight = dataSource?.cellHeaderHeight() ?? cellHeaderHeight
        
        let numberOfSections = collectionView.numberOfSections
        let contentWidth: Double = ruleWidth*24*2
        let contentHeight: Double = Double(numberOfSections) * Double(cellHeaderHeight + cellItemHeight)
        var xPos: CGFloat = 0
        var yPos: CGFloat = 0
        
        contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        guard numberOfSections > 0 else { return }
        for s in 0 ..< numberOfSections {
            
            let headerIndexPath = IndexPath(item: 0, section: s)
            let headerAttributes = self.headerAttributes(forIndexPath: headerIndexPath, position: CGPoint(x: 0.0, y: yPos))
            cellHeadersAttributes[headerIndexPath] = headerAttributes
            
            let numberOfItems = collectionView.numberOfItems(inSection: s)
            guard numberOfItems > 0 else { return }
            for i in 0 ..< numberOfItems {
                
                let itemIndexPath = IndexPath(item: i, section: s)
                let itemAttributes = self.itemAttributes(forIndexPath: itemIndexPath, position: CGPoint(x: xPos, y: yPos))
                cellItemsAttributes[itemIndexPath] = itemAttributes
                
                xPos += itemAttributes?.frame.width ?? 0 + 2
            }
            xPos = 0
            yPos += cellHeaderHeight + cellItemHeight
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesInRect = [UICollectionViewLayoutAttributes]()

        for attributes in cellItemsAttributes.values {
            if rect.intersects(attributes.frame) {
                attributesInRect.append(attributes)
            }
        }
        for attributes in cellHeadersAttributes.values {
            if let collectionView = collectionView {
                attributes.frame.origin.x = collectionView.contentOffset.x
                attributesInRect.append(attributes)
            }
        }
        
        return attributesInRect
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // We have to return true here so that the layout attributes would be recalculated
        // everytime we scroll the collection view.
        return true
    }
    
    // -----------------------------------------------------------------------
    // Private
    // -----------------------------------------------------------------------
    
    private func headerAttributes(forIndexPath indexPath: IndexPath, position: CGPoint) -> UICollectionViewLayoutAttributes {
        
        let attributes = UICollectionViewLayoutAttributes(
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            with: indexPath)
        
        attributes.frame = CGRect(x: position.x, y: position.y + cellItemHeight, width: screenSize.width, height: cellHeaderHeight)
        return attributes
    }
    
    private func itemAttributes(forIndexPath indexPath: IndexPath, position: CGPoint) -> UICollectionViewLayoutAttributes? {
        
        guard let cellTimeDuration = dataSource?.timeDurationForIndexPath(indexPath: indexPath) else { return nil }
        let cellItemWidth = CGFloat(cellTimeDuration)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = CGRect(x: position.x, y: position.y, width: cellItemWidth, height: cellItemHeight)
        return attributes
    }
    
//    private func updateVisibleHeadersPosition() {
//        
//        guard let headers = collectionView?.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader) else { return }
//        for header in headers {
//            if let headerIndexPath = collectionView?.indexPath(for: header as! UICollectionViewCell) {
//                let headerAttributes = self.headerAttributes(forIndexPath: headerIndexPath, position: CGPoint(x: 0.0, y: header.frame.origin.y))
//                cellHeadersAttributes[headerIndexPath] = headerAttributes
//            }
//        }
//    }
}
