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
    
    public var channels = ChannelFactory.generateChannels()
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
        
        var configuration = GridTimerConfiguration()
        configuration.ruleColor = Colors.White
        configuration.ruleBackgroundColor = Colors.Black
        configuration.timerColor = Colors.Fucsia
        configuration.lineColor = Colors.Fucsia
        configuration.selectedItemColor = Colors.Fucsia
        gridTimerView.configuration = configuration
        gridTimerView.register(type: ChannelCollectionViewCell.self)
        gridTimerView.dataSource = self
        gridTimerView.delegate = self
    }
}

extension MainViewController: GridTimerViewDataSource {
    
    func numberOfCells(inGridTimerView: GridTimerView) -> Int {
        return channels.count
    }
    
    func heightForCell(inGridTimerView: GridTimerView) -> CGFloat {
        return 66.0
    }
    
    func heightForEvent(inGridTimerView: GridTimerView) -> CGFloat {
        return 8.0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, numberOfEventsInCellIndex cellIndex: Int) -> Int {
        return channelAt(cellIndex)?.events.count ?? 0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, timeDurationForEventIndex eventIndex: Int, inCellIndex cellIndex: Int) -> Double? {
        
        guard
            let event = eventAt(IndexPath(item: eventIndex, section: cellIndex)),
            let endTime = event.endTime?.timeIntervalSince1970,
            let initTime = event.initTime?.timeIntervalSince1970
            else { return 0 }
        return Double(endTime - initTime)
    }
    
    func gridTimerView(gridTimerView: GridTimerView, cellForEventIndex eventIndex: Int, inCellIndex cellIndex: Int) -> GridViewCell? {
        
        let sectionData = channels[cellIndex]
        let cell = gridTimerView.dequeReusableCell(withType: ChannelCollectionViewCell.self, forCellIndex: cellIndex)
        cell?.source = ChannelCollectionViewCellItem(
            title: sectionData.events[eventIndex].title,
            subtitle: sectionData.events[eventIndex].subtitle,
            image: sectionData.channelImage)
        
        return cell == nil ? ChannelCollectionViewCell() : cell!
    }
}

extension MainViewController: GridTimerViewDelegate {
    
    func gridTimerView(gridTimerView: GridTimerView, didHighlightAtEventIndex eventIndex: Int, inCellIndex cellIndex: Int) {
        
        let sectionData = channels[cellIndex]
        let sectionCell = gridTimerView.cellForIndex(cellIndex: cellIndex) as? ChannelCollectionViewCell
        
        var source = ChannelCollectionViewCellItem()
        source.title = sectionData.events[eventIndex].title
        source.subtitle = sectionData.events[eventIndex].subtitle
        source.image = sectionData.channelImage
        sectionCell?.source = source
    }
    
    func gridTimerView(gridTimerView: GridTimerView, didSelectCellAtIndex cellIndex: Int) {
        
        let sectionCell = gridTimerView.cellForIndex(cellIndex: cellIndex) as? ChannelCollectionViewCell
        let vc = DetailViewController()
        vc.source = DetailViewSource(title: sectionCell?.source?.title, subtitle: sectionCell?.source?.subtitle)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gridTimerView(gridTimerView: GridTimerView, didPullToRefresh loading: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            gridTimerView.endRefresh()
        }
    }
}
