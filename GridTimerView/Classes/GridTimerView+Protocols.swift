//
//  GridTimerView+Protocols.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 7/9/18.
//

import Foundation

public protocol GridTimerViewDataSource: class {
    func numberOfRows(inGridTimerView gridTimerView: GridTimerView) -> Int
    func heightForRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat
    func heightForTimelineRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat
    func gridTimerView(gridTimerView: GridTimerView, numberOfItemsAtRowIndex rowIndex: Int) -> Int
    func gridTimerView(gridTimerView: GridTimerView, viewForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> GridViewCell?
    func gridTimerView(gridTimerView: GridTimerView, timeDurationForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Double?
}

public protocol GridTimerViewDelegate: class {
    func gridTimerView(gridTimerView: GridTimerView, didHighlightAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int)
    func gridTimerView(gridTimerView: GridTimerView, didSelectRowAtIndex rowIndex: Int)
    func didPullToRefresh(inGridTimerView gridTimerView: GridTimerView)
}
