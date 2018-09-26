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
    
    public var channels = ChannelFactory.generateChannels(14, withShows: 0)
    private var firstLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupGridTimerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        channels = ChannelFactory.generateChannels()
//        gridTimerView.reloadGridData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !firstLoad {
            let date = Date.add(days: -1).addingTimeInterval(60*60*3)
            gridTimerView?.scrollToDate(date: date)
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
        gridTimerView.register(type: ChannelItemView.self)
        gridTimerView.dataSource = self
        gridTimerView.delegate = self
    }
    
    func simulateEventsRequest(forRow rowIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.channels[rowIndex].events = ChannelFactory.generateEvents(5, inRow: rowIndex)
            self.gridTimerView.reloadGridRowIndex(rowIndex)
        }
    }
}

extension MainViewController: GridTimerViewDataSource {
    
    func numberOfRows(inGridTimerView gridTimerView: GridTimerView) -> Int {
        return channels.count
    }
    
    func heightForRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
        return 54.0
    }
    
    func heightForTimelineRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
        return 8.0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, numberOfItemsAtRowIndex rowIndex: Int) -> Int {
        return channelAt(rowIndex)?.events.count ?? 0
    }
    
    func gridTimerView(gridTimerView: GridTimerView, setupView itemView: GridItemView, forItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> GridItemView {
        
        let sectionData = channels[rowIndex]
        let cell = itemView as! ChannelItemView
        
        if sectionData.events.count > 0 {
            cell.source = ChannelItemViewSource(
                title: sectionData.events[itemIndex].title,
                subtitle: sectionData.events[itemIndex].subtitle,
                image: sectionData.channelImage)
        } else {
            cell.source = ChannelItemViewSource(
                title: "Loading",
                subtitle: "",
                image: nil)
            simulateEventsRequest(forRow: rowIndex)
        }
        
        return cell
    }
    
    func gridTimerView(gridTimerView: GridTimerView, startTimeForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date {
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
        
    }
    
    func gridTimerView(gridTimerView: GridTimerView, didSelectRowAtIndex rowIndex: Int) {
        
        let sectionCell = gridTimerView.viewForRowIndex(rowIndex: rowIndex) as? ChannelItemView
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
