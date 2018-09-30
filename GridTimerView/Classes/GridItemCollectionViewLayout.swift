//
//  GridItemCollectionViewLayout.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 28/9/18.
//

import UIKit

protocol GridItemCollectionViewLayoutDataSource: class {
    func initDateForIndexPath(indexPath: IndexPath) -> Date?
    func endDateForIndexPath(indexPath: IndexPath) -> Date?
    func cellItemHeight() -> CGFloat?
}

class GridItemCollectionViewLayout: UICollectionViewFlowLayout {

    weak var dataSource: GridItemCollectionViewLayoutDataSource?

    private var cellItemsAttributes = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    private var contentSize = CGSize(width: 0, height: 0)
    private var screenSize = UIScreen.main.bounds.size
    
    var cellItemHeight: CGFloat = 8.0
    var ruleDaysFrom = 1
    var ruleDaysTo = 2
    // var reloadAttributes = true

    override func prepare() {

        // guard reloadAttributes else { return }
        guard let collectionView = collectionView else { return }

        // reloadAttributes = false
        // Clear cache
        cellItemsAttributes = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()

        cellItemHeight = dataSource?.cellItemHeight() ?? cellItemHeight

        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let contentWidth: Double = Double(ruleWidth) * 24 * Double(ruleDaysTo + ruleDaysFrom)
        let contentHeight: Double = Double(cellItemHeight)
        
        contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        if numberOfItems > 0 {
            for i in 0 ..< numberOfItems {
                let itemIndexPath = IndexPath(item: i, section: 0)
                let attributes = self.itemAttributes(forIndexPath: itemIndexPath)
                cellItemsAttributes[itemIndexPath] = attributes
            }
        }
    }

    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        for attributes in cellItemsAttributes.values {
            if rect.intersects(attributes.frame) {
                attributesInRect.append(attributes)
            }
        }
        
        return attributesInRect
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // We have to return true here so that the layout attributes would be recalculated
        // everytime we scroll the collection view.
        return false
    }

    // -----------------------------------------------------------------------
    // Private
    // -----------------------------------------------------------------------

    private func itemAttributes(forIndexPath indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

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
        attributes.frame = CGRect(x: xPos, y: 0, width: cellItemWidth, height: cellItemHeight)
        return attributes
    }
}
