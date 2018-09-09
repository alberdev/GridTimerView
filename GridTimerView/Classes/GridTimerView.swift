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
    
    public var refresher: UIRefreshControl?
    private var currentTimeLine: UIView?
    public var firstScroll = false
    public let scrollRefreshLimitY: CGFloat = -120
    public var customCellType: GridItemView.Type?
    private let screenSize = UIScreen.main.bounds.size
    private let initialInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
    private let loadingInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    
    
    /////////////////////////////////////////////////////////////////////////////
    /// The object that provides the data for the collection view
    /// - Note: The data source must adopt the `GridTimerViewDataSource` protocol.
    
    weak open var dataSource: GridTimerViewDataSource?
    
    /////////////////////////////////////////////////////////////////////////////
    /// The object that acts as the delegate of the gridtimer view. The delegate
    /// object is responsible for managing selection behavior and interactions with
    /// individual items.
    /// - Note: The delegate must adopt the `GridTimerViewDelegate` protocol.

    weak open var delegate: GridTimerViewDelegate?
    
    /////////////////////////////////////////////////////////////////////////////
    /// Object that configure `GridTimerView` view. You can setup `GridTimerView` with
    /// your own parameters. See also `GridTimerConfiguration` implementation.
    
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
            timeLineColor = configuration.timeLineColor
            timerLineView.backgroundColor = configuration.lineColor
            
            if let collectionViewLayout = collectionView.collectionViewLayout as? CustomCollectionViewLayout {
                collectionViewLayout.ruleDaysFrom = configuration.ruleDaysFrom
                collectionViewLayout.ruleDaysTo = configuration.ruleDaysTo
            }
        }
    }
    
    var timeLineColor = UIColor.green {
        didSet {
            currentTimeLine?.backgroundColor = timeLineColor
        }
    }
    
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
        setupCurrentTimeLine()
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
        collectionView.register(GridItemView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: GridItemView.uniqueIdentifier)
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
    
    private func setupCurrentTimeLine() {
        let xPos = xPosition(byDate: Date(), fromInitDate: Date.add(days: -configuration.ruleDaysFrom))
        currentTimeLine = UIView(frame: CGRect(x: xPos, y: 0, width: 1, height: collectionView.contentSize.height))
        currentTimeLine?.backgroundColor = timeLineColor
        collectionView.addSubview(currentTimeLine!)
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
        delegate?.didPullToRefresh(inGridTimerView: self)
    }
    
    public func dequeReusableView<T: UICollectionViewCell>(withType type: T.Type, forRowIndex rowIndex: Int) -> T? {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.uniqueIdentifier, for: IndexPath(item: 0, section: rowIndex)) as? T
    }
}

extension GridTimerView: GridTimerViewInterface {
    
    open func scrollToDate(date: Date) {
        let offsetY = collectionView.contentOffset.y
        let offsetX = CGFloat(date.timeIntervalSince1970 - Date.add(days: -configuration.ruleDaysFrom).timeIntervalSince1970)*96.2/3600 - screenSize.width/2
        collectionView.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: true)
    }
    
    open func viewForRowIndex(rowIndex: Int) -> GridItemView? {
        return collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: rowIndex)) as? GridItemView
    }
    
    open func register<T: UICollectionViewCell>(type: T.Type) {
        collectionView.register(type.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: type.uniqueIdentifier)
        customCellType = type as? GridItemView.Type
    }
    
    open func endRefresh() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.contentInset = self.initialInset
        }
    }
}


