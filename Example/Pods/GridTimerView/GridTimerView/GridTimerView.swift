//
//  TimerGridView.swift
//  TableTimer
//
//  Created by Alberto Aznar de los Ríos on 4/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.

import UIKit

protocol GridTimerViewDataSource: class {
    func numberOfSections(inGridTimerView: GridTimerView) -> Int
    func cellHeaderHeight(inGridTimerView: GridTimerView) -> CGFloat
    func cellItemHeight(inGridTimerView: GridTimerView) -> CGFloat
    func gridTimerView(gridTimerView: GridTimerView, numberOfItemsInSection section: Int) -> Int
    func gridTimerView(gridTimerView: GridTimerView, collectionView: UICollectionView, cellForIndexPath indexPath: IndexPath) -> UICollectionViewCell
    func gridTimerView(gridTimerView: GridTimerView, timeDurationForIndexPath indexPath: IndexPath) -> Double?
}

protocol GridTimerViewDelegate: class {
    func gridTimerView(gridTimerView: GridTimerView, didHighlightItemAtIndexPath indexPath: IndexPath)
    func gridTimerView(gridTimerView: GridTimerView, didSelectItemAtIndexPath indexPath: IndexPath)
}

public class GridTimerView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak private var ruleView: RuleView!
    @IBOutlet weak private var timerLineView: UIView!
    
    weak var dataSource: GridTimerViewDataSource?
    weak var delegate: GridTimerViewDelegate?
    
    var ruleFont = UIFont.systemFont(ofSize: 10, weight: .semibold) {
        didSet {
            ruleView.ruleFont = ruleFont
        }
    }
    var ruleTextColor = UIColor.lightGray {
        didSet {
            ruleView.ruleTextColor = ruleTextColor
        }
    }
    var ruleDaysFrom = 1 {
        didSet {
            ruleView.ruleDaysFrom = ruleDaysFrom
        }
    }
    var ruleDaysTo = 2 {
        didSet {
            ruleView.ruleDaysTo = ruleDaysTo
        }
    }
    var ruleBackgroundColor = UIColor.darkGray {
        didSet {
            ruleView.ruleBackgroundColor = ruleBackgroundColor
        }
    }
    var ruleColor = UIColor.white {
        didSet {
            ruleView.ruleColor = ruleColor
        }
    }
    var timerFont = UIFont.systemFont(ofSize: 12, weight: .semibold) {
        didSet {
            ruleView.timerFont = timerFont
        }
    }
    var timerColor = UIColor.blue {
        didSet {
            ruleView.timerColor = timerColor
        }
    }
    var timerTextColor = UIColor.white {
        didSet {
            ruleView.timerTextColor = timerTextColor
        }
    }
    var lineColor = UIColor.blue {
        didSet {
            timerLineView.backgroundColor = lineColor
        }
    }
    var selectedItemColor = UIColor.blue
    
    private var refresher: UIRefreshControl?
    private var firstLoad = false
    private let screenSize = UIScreen.main.bounds.size
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("GridTimerView", owner: self, options: nil)
        contentView.fixConstraintsInView(self)
        setupCollectionView()
        //setupRefresher()
        setupRuleView()
        setupLineView()
    }
    
    private func setupCollectionView() {
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? CustomCollectionViewLayout {
            collectionViewLayout.dataSource = self
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
    }
    
    private func setupRefresher() {
        refresher = UIRefreshControl()
        refresher?.tintColor = UIColor.lightGray
        refresher?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        refresher?.backgroundColor = .white
        collectionView.addSubview(refresher!)
    }
    
    private func setupRuleView() {
        ruleView.ruleFont = ruleFont
        ruleView.ruleTextColor = ruleTextColor
        ruleView.ruleDaysFrom = ruleDaysFrom
        ruleView.ruleDaysTo = ruleDaysTo
        ruleView.timerFont = timerFont
        ruleView.timerColor = timerColor
        ruleView.timerTextColor = timerTextColor
    }
    
    private func setupLineView() {
        timerLineView.backgroundColor = lineColor
    }
    
    @objc private func loadData() {
        refresher?.endRefreshing()
    }
    
    func scrollToDate(date: Date) {
        let offsetY = collectionView.contentOffset.y
        let offsetX = CGFloat(date.timeIntervalSince1970 - Date.add(days: -ruleDaysFrom).timeIntervalSince1970)*96.2/3600 - screenSize.width/2
        collectionView.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: true)
    }
    
    func cellSectionForIndexPath(indexPath: IndexPath) -> UICollectionReusableView? {
        return collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: indexPath.section))
    }
    
    func register<T: UICollectionViewCell>(type: T.Type) {
        collectionView.register(type.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.uniqueIdentifier)
    }
}

extension GridTimerView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ruleView.updateContentOffset(x: scrollView.contentOffset.x)
        
        for cell in collectionView.visibleCells {
            
            let initPoint = cell.frame.origin.x
            let endPoint = cell.frame.origin.x + cell.frame.size.width
            let timerLinePoint = convert(timerLineView.frame.origin, to: collectionView)
            if initPoint-1 < timerLinePoint.x && endPoint+1 >= timerLinePoint.x {
                cell.backgroundColor = selectedItemColor
                if let indexPath = collectionView.indexPath(for: cell) {
                    delegate?.gridTimerView(gridTimerView: self, didHighlightItemAtIndexPath: indexPath)
                }
            } else {
                cell.backgroundColor = .lightGray
            }
        }
    }
}

extension GridTimerView: CustomCollectionViewLayoutDataSource {
    
    func timeDurationForIndexPath(indexPath: IndexPath) -> Double? {
        return dataSource?.gridTimerView(gridTimerView: self, timeDurationForIndexPath: indexPath)
    }
    
    func cellHeaderHeight() -> CGFloat? {
        return dataSource?.cellHeaderHeight(inGridTimerView: self)
    }
    
    func cellItemHeight() -> CGFloat? {
        return dataSource?.cellItemHeight(inGridTimerView: self)
    }
}

extension GridTimerView: GridCollectionViewCellDelegate {
    
    func gridCollectionViewCell(gridCollectionViewCell: GridCollectionViewCell, didSelect selected: Bool) {
        if let indexPath = gridCollectionViewCell.indexPath {
            delegate?.gridTimerView(gridTimerView: self, didSelectItemAtIndexPath: indexPath)
        }
    }
}
