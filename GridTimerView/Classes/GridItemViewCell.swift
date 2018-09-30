//
//  HeaderCollectionViewCell.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 5/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

protocol GridItemViewCellDataSource: class {
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, numberOfItemsInRowIndex rowIndex: Int) -> Int
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, colorForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> UIColor?
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, containerViewForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> UIView?
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, initDateForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date?
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, endDateForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date?
}

protocol GridItemViewCellDelegate: class {
    func gridItemViewCell(_ gridItemViewCell: GridItemViewCell, didHighlightAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int)
}

public class GridItemViewCell: UICollectionViewCell {
    
    struct ViewModel {
        var selectedCellColor: UIColor
        var selectedItemColor: UIColor
        var unselectedItemColor: UIColor
        var containerViewHeight: CGFloat
        var collectionViewHeight: CGFloat
        var item: Int
        var row: Int
    }
    
    weak var dataSource: GridItemViewCellDataSource?
    weak var delegate: GridItemViewCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    private let screenSize = UIScreen.main.bounds.size
    
    var userView: UIView?
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            containerViewHeightConstraint.constant = viewModel.containerViewHeight
            collectionViewHeightConstraint.constant = viewModel.collectionViewHeight
        }
    }
    
    open override func awakeFromNib() {
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.dataSource = self
        collectionView.register(GridTimeLineView.self, forCellWithReuseIdentifier: GridTimeLineView.uniqueIdentifier)
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? GridItemCollectionViewLayout {
            collectionViewLayout.dataSource = self
        }
    }
    
    func addCustomUserView(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: containerView.bounds.height)
        containerView.addSubview(view)
        userView = view
    }
    
    func removeCustomUserView() {
        userView?.removeFromSuperview()
    }
    
    internal func updateHighlightedItems() {
        for cell in collectionView.visibleCells as! [GridTimeLineView] {
//            let timerLineFrame = convert(CGRect(x: screenSize.width/2, y: 0, width: 1, height: screenSize.height), to: collectionView)
//            if cell.frame.intersects(timerLineFrame) {
                
            let initPoint = cell.frame.origin.x
            let endPoint = cell.frame.origin.x + cell.frame.size.width
            let timerLineCenter = CGPoint(x: screenSize.width/2, y: 0)
            let timerLinePoint = convert(timerLineCenter, to: collectionView)
            if initPoint < timerLinePoint.x && endPoint >= timerLinePoint.x {
                
                guard
                    let indexPath = collectionView.indexPath(for: cell),
                    cell.isOn == false
                    else { return }
                
                cell.isOn = true
                viewModel?.item = indexPath.item
                delegate?.gridItemViewCell(self, didHighlightAtItemIndex: indexPath.item, inRowIndex: viewModel?.row ?? 0)
                
                // Update cell with highlighted item
                guard let view = dataSource?.gridItemViewCell(self, containerViewForItemIndex: indexPath.item, inRowIndex: viewModel?.row ?? 0) else { return }
                removeCustomUserView()
                addCustomUserView(view: view)
                
            } else {
                cell.isOn = false
            }
        }
    }
    
    override public var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                containerView.backgroundColor = viewModel?.selectedCellColor
            } else {
                containerView.backgroundColor = .white
            }
        }
    }
}

extension GridItemViewCell: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.gridItemViewCell(self, numberOfItemsInRowIndex: viewModel?.row ?? 0) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridTimeLineView.uniqueIdentifier, for: indexPath) as! GridTimeLineView
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 0.5
        cell.selectedItemColor = dataSource?.gridItemViewCell(self, colorForItemIndex: indexPath.item, inRowIndex: viewModel?.row ?? 0) ?? viewModel?.selectedItemColor
        cell.unselectedItemColor = viewModel?.unselectedItemColor
        cell.isOn = false
        return cell
    }
}

extension GridItemViewCell: GridItemCollectionViewLayoutDataSource {
    
    func initDateForIndexPath(indexPath: IndexPath) -> Date? {
        return dataSource?.gridItemViewCell(self, initDateForItemIndex: indexPath.item, inRowIndex: viewModel?.row ?? 0)
    }
    
    func endDateForIndexPath(indexPath: IndexPath) -> Date? {
        return dataSource?.gridItemViewCell(self, endDateForItemIndex: indexPath.item, inRowIndex: viewModel?.row ?? 0)
    }
    
    func cellItemHeight() -> CGFloat? {
        return collectionViewHeightConstraint.constant
    }
}
