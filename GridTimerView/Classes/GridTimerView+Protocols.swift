//
//  GridTimerView+Protocols.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 7/9/18.
//

import Foundation

public protocol GridTimerViewDataSource: class {
    func numberOfCells(inGridTimerView: GridTimerView) -> Int
    func heightForCell(inGridTimerView: GridTimerView) -> CGFloat
    func heightForEvent(inGridTimerView: GridTimerView) -> CGFloat
    func gridTimerView(gridTimerView: GridTimerView, numberOfEventsInCellIndex cellIndex: Int) -> Int
    func gridTimerView(gridTimerView: GridTimerView, cellForEventIndex eventIndex: Int, inCellIndex cellIndex: Int) -> GridViewCell?
    func gridTimerView(gridTimerView: GridTimerView, timeDurationForEventIndex eventIndex: Int, inCellIndex cellIndex: Int) -> Double?
}

public protocol GridTimerViewDelegate: class {
    func gridTimerView(gridTimerView: GridTimerView, didHighlightAtEventIndex eventIndex: Int, inCellIndex cellIndex: Int)
    func gridTimerView(gridTimerView: GridTimerView, didSelectCellAtIndex cellIndex: Int)
    func gridTimerView(gridTimerView: GridTimerView, didPullToRefresh loading: Bool)
}
