//
//  TimerGridView.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 4/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.

import UIKit

open class GridTimerView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak public var collectionView: UICollectionView!
    @IBOutlet weak public var ruleView: RuleView!
    @IBOutlet weak public var timerLineView: UIView!
    @IBOutlet weak public var backScrollView: UIScrollView!
    
    weak open var dataSource: GridTimerViewDataSource?
    weak open var delegate: GridTimerViewDelegate?
    
    open var configuration = GridTimerConfiguration() {
        didSet {
            ruleView.ruleFont = configuration.ruleFont
            ruleView.ruleTextColor = configuration.ruleTextColor
            ruleView.ruleDaysFrom = configuration.ruleDaysFrom
            ruleView.ruleDaysTo = configuration.ruleDaysTo
            ruleView.ruleBackgroundColor = configuration.ruleBackgroundColor
            ruleView.ruleColor = configuration.ruleColor
            ruleView.timerFont = configuration.timerFont
            ruleView.timerColor = configuration.timerColor
            ruleView.timerTextColor = configuration.timerTextColor
            timerLineView.backgroundColor = configuration.lineColor
        }
    }
    
    public var refresher: UIRefreshControl?
    private let screenSize = UIScreen.main.bounds.size
    private let initialInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
    private let loadingInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        _ = fromNib()
        setupCollectionView()
        setupRefresher()
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
        collectionView.contentInset = initialInset
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EventCell")
        collectionView.register(GridViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GridViewCell.uniqueIdentifier)
    }
    
    private func setupRuleView() {
        ruleView.ruleFont = configuration.ruleFont
        ruleView.ruleTextColor = configuration.ruleTextColor
        ruleView.ruleDaysFrom = configuration.ruleDaysFrom
        ruleView.ruleDaysTo = configuration.ruleDaysTo
        ruleView.timerFont = configuration.timerFont
        ruleView.timerColor = configuration.timerColor
        ruleView.timerTextColor = configuration.timerTextColor
    }
    
    private func setupLineView() {
        timerLineView.backgroundColor = configuration.lineColor
    }
    
    private func setupRefresher() {
        refresher = UIRefreshControl()
        refresher?.tintColor = UIColor.lightGray
        refresher?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        refresher?.backgroundColor = .clear
        backScrollView.addSubview(refresher!)
    }
    
    @objc private func didPullToRefresh() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.contentInset = self.loadingInset
        }
        delegate?.gridTimerView(gridTimerView: self, didPullToRefresh: true)
    }
}

extension GridTimerView {
    
    open func scrollToDate(date: Date) {
        let offsetY = collectionView.contentOffset.y
        let offsetX = CGFloat(date.timeIntervalSince1970 - Date.add(days: -configuration.ruleDaysFrom).timeIntervalSince1970)*96.2/3600 - screenSize.width/2
        collectionView.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: true)
    }
    
    open func cellForIndex(cellIndex: Int) -> GridViewCell? {
        return collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: cellIndex)) as? GridViewCell
    }
    
    open func register<T: UICollectionViewCell>(type: T.Type) {
        collectionView.register(type.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.uniqueIdentifier)
    }
    
    open func dequeReusableCell<T: UICollectionViewCell>(withType type: T.Type, forCellIndex cellIndex: Int) -> T? {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.uniqueIdentifier, for: IndexPath(item: 0, section: cellIndex)) as? T
    }
    
    open func endRefresh() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.contentInset = self.initialInset
        }
    }
}


