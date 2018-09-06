//
//  MainViewController.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 2/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit
import GridTimerView

class MainViewController: UIViewController {
    
    @IBOutlet weak var gridTimerView: GridTimerView!
    
    private var sections = SectionsFactory.generateSections()
    private var firstLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupGridTimerView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !firstLoad {
            gridTimerView?.scrollToDate(date: Date())
            firstLoad = true
        }
    }
    
    @objc func didPressTodayButton(_ sender: UIButton) {
        gridTimerView?.scrollToDate(date: Date())
    }
    
    public func itemAt(_ index: Int) -> Section? {
        return self.sections.element(at: index)
    }
    
    public func itemAt(_ indexPath: IndexPath) -> Item? {
        return self.itemAt(indexPath.section)?.items.element(at: indexPath.row)
    }
    
    private func setupNavigation() {
        let rightButtonItem = UIBarButtonItem.init(
            title: "Now",
            style: .done,
            target: self,
            action: #selector(didPressTodayButton)
        )
        title = "GridTimerView"
        navigationItem.rightBarButtonItems = [rightButtonItem]
        navigationController?.navigationBar.tintColor = Colors.Fucsia
    }
    
    private func setupGridTimerView() {
        gridTimerView?.dataSource = self
        gridTimerView?.delegate = self
        gridTimerView?.ruleColor = Colors.White
        gridTimerView?.ruleBackgroundColor = Colors.Black
        gridTimerView?.timerColor = Colors.Fucsia
        gridTimerView?.lineColor = Colors.Fucsia
        gridTimerView?.selectedItemColor = Colors.Fucsia
        gridTimerView?.register(type: SectionCollectionViewCell.self)
    }
}

extension MainViewController: GridTimerViewDataSource {
    
    func numberOfSections(inGridTimerView: GridTimerView) -> Int {
        return sections.count
    }
    
    func cellHeaderHeight(inGridTimerView: GridTimerView) -> CGFloat {
        return 66.0
    }
    
    func cellItemHeight(inGridTimerView: GridTimerView) -> CGFloat {
        return 8.0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, numberOfItemsInSection section: Int) -> Int {
        return self.itemAt(section)?.items.count ?? 0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, collectionView: UICollectionView, cellForIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionData = sections[indexPath.section]
        let cell = SectionCollectionViewCell.reuse(
            collectionView,
            indexPath: indexPath,
            kind: UICollectionElementKindSectionHeader) as? SectionCollectionViewCell
        
        cell?.source = SectionCollectionViewCellItem(
            title: sectionData.items[indexPath.item].title,
            subtitle: sectionData.items[indexPath.item].subtitle,
            image: UIImage(named: "Placeholder"))
        
        return cell == nil ? SectionCollectionViewCell() : cell!
    }
    
    func gridTimerView(gridTimerView: GridTimerView, timeDurationForIndexPath indexPath: IndexPath) -> Double? {
        guard
            let item = itemAt(indexPath),
            let endTime = item.endTime?.timeIntervalSince1970,
            let initTime = item.initTime?.timeIntervalSince1970
            else { return 0 }
        return Double(endTime - initTime)
    }
}

extension MainViewController: GridTimerViewDelegate {
    
    func gridTimerView(gridTimerView: GridTimerView, didHighlightItemAtIndexPath indexPath: IndexPath) {
        let sectionData = sections[indexPath.section]
        let sectionCell = gridTimerView.cellSectionForIndexPath(indexPath: indexPath) as? SectionCollectionViewCell
        
        var source = SectionCollectionViewCellItem()
        source.title = sectionData.items[indexPath.item].title
        source.subtitle = sectionData.items[indexPath.item].subtitle
        source.image = UIImage(named: "Placeholder")
        sectionCell?.source = source
    }
    
    func gridTimerView(gridTimerView: GridTimerView, didSelectItemAtIndexPath indexPath: IndexPath) {
        print("Did select cell at index path: \(indexPath)")
    }
}
