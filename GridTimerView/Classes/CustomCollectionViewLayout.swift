//
//  CustomCollectionViewLayout.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 5/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

protocol CustomCollectionViewLayoutDataSource: class {
    func initDateForIndexPath(indexPath: IndexPath) -> Date?
    func endDateForIndexPath(indexPath: IndexPath) -> Date?
    func cellHeaderHeight() -> CGFloat?
    func cellItemHeight() -> CGFloat?
}

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: CustomCollectionViewLayoutDataSource?
    
    var cellItemHeight: CGFloat = 8.0
    var cellHeaderHeight: CGFloat = 54.0
    var cellSeparation: CGFloat = 10.0
    var ruleDaysFrom = 1
    var ruleDaysTo = 2
    
    private var cellItemsAttributes = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    private var cellHeadersAttributes = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
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
        let contentWidth: Double = Double(ruleWidth) * 24 * Double(ruleDaysTo + ruleDaysFrom)
        let contentHeight: Double = Double(numberOfSections) * Double(cellHeaderHeight + cellSeparation + cellItemHeight)
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
                let itemAttributes = self.itemAttributes(forIndexPath: itemIndexPath, yPosition: yPos)
                cellItemsAttributes[itemIndexPath] = itemAttributes
            }
            yPos += cellHeaderHeight + cellSeparation + cellItemHeight
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
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            with: indexPath)
        
        attributes.frame = CGRect(x: position.x, y: position.y + cellItemHeight, width: screenSize.width, height: cellHeaderHeight)
        return attributes
    }
    
    private func itemAttributes(forIndexPath indexPath: IndexPath, yPosition: CGFloat) -> UICollectionViewLayoutAttributes? {
        
        guard
            let initDate = dataSource?.initDateForIndexPath(indexPath: indexPath),
            let endDate = dataSource?.endDateForIndexPath(indexPath: indexPath)
            else { return nil }
        
        let initTime = initDate.timeIntervalSince1970
        let endTime = endDate.timeIntervalSince1970
        let cellTimeDuration = Int(endTime - initTime)
        let cellItemWidth = floatForTime(seconds: cellTimeDuration)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let xPos = xPosition(byDate: initDate, fromInitDate: Date.add(days: -ruleDaysFrom))
        attributes.frame = CGRect(x: xPos, y: yPosition, width: cellItemWidth, height: cellItemHeight)
        return attributes
    }
}
