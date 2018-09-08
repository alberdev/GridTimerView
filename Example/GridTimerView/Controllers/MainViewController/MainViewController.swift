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
    
    func numberOfRows(inGridTimerView gridTimerView: GridTimerView) -> Int {
        return channels.count
    }
    
    func heightForRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
        return 66.0
    }
    
    func heightForTimelineRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
        return 8.0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, numberOfItemsAtRowIndex rowIndex: Int) -> Int {
        return channelAt(rowIndex)?.events.count ?? 0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, setupView itemView: GridItemView, forItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> GridItemView {
        
        let sectionData = channels[rowIndex]
        let cell = itemView as! ChannelCollectionViewCell
        cell.source = ChannelCollectionViewCellItem(
            title: sectionData.events[itemIndex].title,
            subtitle: sectionData.events[itemIndex].subtitle,
            image: sectionData.channelImage)
        
        return cell
    }
    
    func gridTimerView(gridTimerView: GridTimerView, initTimeForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date {
        let event = eventAt(IndexPath(item: itemIndex, section: rowIndex))
        return event?.initTime ?? Date()
    }
    
    func gridTimerView(gridTimerView: GridTimerView, endTimeForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date {
        let event = eventAt(IndexPath(item: itemIndex, section: rowIndex))
        return event?.endTime ?? Date()
    }
}

extension MainViewController: GridTimerViewDelegate {
    
    func gridTimerView(gridTimerView: GridTimerView, didHighlightAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int) {
        
        let sectionData = channels[rowIndex]
        let sectionCell = gridTimerView.viewForRowIndex(rowIndex: rowIndex) as? ChannelCollectionViewCell
        
        var source = ChannelCollectionViewCellItem()
        source.title = sectionData.events[itemIndex].title
        source.subtitle = sectionData.events[itemIndex].subtitle
        source.image = sectionData.channelImage
        sectionCell?.source = source
    }
    
    func gridTimerView(gridTimerView: GridTimerView, didSelectRowAtIndex rowIndex: Int) {
        
        let sectionCell = gridTimerView.viewForRowIndex(rowIndex: rowIndex) as? ChannelCollectionViewCell
        let vc = DetailViewController()
        vc.source = DetailViewSource(title: sectionCell?.source?.title, subtitle: sectionCell?.source?.subtitle)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didPullToRefresh(inGridTimerView gridTimerView: GridTimerView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            gridTimerView.endRefresh()
        }
    }
}
