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
    public var currentTimeLine: UIView?
    public var firstScroll = false
    public let scrollRefreshLimitY: CGFloat = -120
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
            ruleView.ruleTicksColor = configuration.ruleTicksColor
            ruleView.timerFont = configuration.timerFont
            ruleView.timerColor = configuration.timerColor
            ruleView.timerTextColor = configuration.timerTextColor
            ruleView.currentTimeLineDashed = configuration.currentTimeLineDashed
            ruleView.currentTimeLineColor = configuration.currentTimeLineColor
            timerLineView.backgroundColor = configuration.lineColor
            backScrollView.isHidden = !configuration.enableRefresh
            
            if let collectionViewLayout = collectionView.collectionViewLayout as? CustomCollectionViewLayout {
                collectionViewLayout.ruleDaysFrom = configuration.ruleDaysFrom
                collectionViewLayout.ruleDaysTo = configuration.ruleDaysTo
                // collectionViewLayout.cellSeparation = configuration.rowSeparation
            }
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
    }
    
    private func setupCollectionView() {
        
        if let collectionViewLayout = collectionView.collectionViewLayout as? CustomCollectionViewLayout {
            collectionViewLayout.dataSource = self
        }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = initialInset
        collectionView.registerInClass(self.classForCoder, forCellWithReuseIdentifier: GridItemViewCell.uniqueIdentifier)
    }
    
    private func setupRuleView() {
        ruleView.ruleFont = configuration.ruleFont
        ruleView.ruleTextColor = configuration.ruleTextColor
        ruleView.ruleDaysFrom = configuration.ruleDaysFrom
        ruleView.ruleDaysTo = configuration.ruleDaysTo
        ruleView.timerFont = configuration.timerFont
        ruleView.timerColor = configuration.timerColor
        ruleView.timerTextColor = configuration.timerTextColor
        ruleView.currentTimeLineDashed = configuration.currentTimeLineDashed
        ruleView.currentTimeLineColor = configuration.currentTimeLineColor
    }
    
    private func setupLineView() {
        timerLineView.backgroundColor = configuration.lineColor
    }
    
    private func setupRefresher() {
        refresher = UIRefreshControl()
        refresher?.tintColor = UIColor.lightGray
        refresher?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        refresher?.backgroundColor = .clear
        backScrollView.isHidden = !configuration.enableRefresh
        backScrollView.addSubview(refresher!)
    }
    
    @objc private func didPullToRefresh() {
        if configuration.enableRefresh {
            UIView.animate(withDuration: 0.3) {
                self.collectionView.contentInset = self.loadingInset
            }
            delegate?.didPullToRefresh(inGridTimerView: self)
        }
    }
}

extension GridTimerView: GridTimerViewInterface {
    
    open func scrollToDate(date: Date) {
        let offsetY = collectionView.contentOffset.y
        let offsetX = CGFloat(date.timeIntervalSince1970 - Date.add(days: -configuration.ruleDaysFrom).timeIntervalSince1970)*96.2/3600 - screenSize.width/2
        collectionView.setContentOffset(CGPoint(x: offsetX, y: offsetY), animated: true)
    }
    
    open func viewForRowIndex(rowIndex: Int) -> UIView? {
        let cell = collectionView.cellForItem(at: IndexPath(item: rowIndex, section: 0)) as! GridItemViewCell
        return cell.userView
    }

    open func endRefresh() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.contentInset = self.initialInset
        }
    }
    
    open func reloadGridData() {
        if let collectionViewLayout = collectionView.collectionViewLayout as? CustomCollectionViewLayout {
            collectionViewLayout.reloadAttributes = true
            collectionView.reloadData()
        }
    }
    
    open func reloadGridRowIndex(_ rowIndex: Int) {
        UIView.performWithoutAnimation {
            collectionView.reloadItems(at: [IndexPath(item: rowIndex, section: 0)])
        }
    }
}


