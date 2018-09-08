//
//  GridTimerView+Protocols.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 7/9/18.
//

import Foundation

public protocol GridTimerViewDataSource: class {
    
    /**
     ------------------------------------------------------------------------------------------
     Returns number of rows in the table (no events)
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     */
    func numberOfRows(inGridTimerView gridTimerView: GridTimerView) -> Int
    
    /**
     ------------------------------------------------------------------------------------------
     Returns height of custom row in the table (no events)
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     */
    func heightForRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat
    
    /**
     ------------------------------------------------------------------------------------------
     Returns height of highlighted items
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     */
    func heightForTimelineRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat
    
    /**
     ------------------------------------------------------------------------------------------
     Returns number of items in row
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter rowIndex: row index
     */
    func gridTimerView(gridTimerView: GridTimerView, numberOfItemsAtRowIndex rowIndex: Int) -> Int
    
    /**
     ------------------------------------------------------------------------------------------
     Returns custom row view (no event)
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter itemIndex: item index
     - parameter rowIndex: row index
     */
    func gridTimerView(gridTimerView: GridTimerView, viewForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> GridItemView?
    
    /**
     ------------------------------------------------------------------------------------------
     Returns event duration
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter itemIndex: item index
     - parameter rowIndex: row index
     */
    func gridTimerView(gridTimerView: GridTimerView, timeDurationForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Double?
}

public extension GridTimerViewDataSource {
    
    func heightForRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
        // Optional
        return 66
    }
    
    func heightForTimelineRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat {
        // Optional
        return 8
    }
}

public protocol GridTimerViewDelegate: class {
    
    /**
     ------------------------------------------------------------------------------------------
     Is called when item is highlighted
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: gridTimerView is using
     - parameter itemIndex: item index
     - parameter rowIndex: row index
     */
    func gridTimerView(gridTimerView: GridTimerView, didHighlightAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int)
    
    /**
     ------------------------------------------------------------------------------------------
    Is called when row is selected
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: gridTimerView is using
     - parameter rowIndex: row index
     */
    func gridTimerView(gridTimerView: GridTimerView, didSelectRowAtIndex rowIndex: Int)
    
    /**
     ------------------------------------------------------------------------------------------
     Is called when row is selected
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: gridTimerView is using
     - parameter rowIndex: row index
     */
    func didPullToRefresh(inGridTimerView gridTimerView: GridTimerView)
}

public extension GridTimerViewDelegate {
    
    func gridTimerView(gridTimerView: GridTimerView, didHighlightAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int) {
        // Optional
    }
    
    func didPullToRefresh(inGridTimerView gridTimerView: GridTimerView) {
        // Optional
    }
}

public protocol GridTimerViewInterface {
    
    /**
     ------------------------------------------------------------------------------------------
     Scroll imer to single date programatically
     ------------------------------------------------------------------------------------------
     - parameter date: date you want scroll to
     */
    func scrollToDate(date: Date)
    
    /**
     ------------------------------------------------------------------------------------------
     This method obtain row by index
     ------------------------------------------------------------------------------------------
     - parameter rowIndex: row index
     */
    func viewForRowIndex(rowIndex: Int) -> GridItemView?
    
    /**
     ------------------------------------------------------------------------------------------
     Register your own row is needed for reuse in table
     ------------------------------------------------------------------------------------------
     - parameter type: class name you want to register
     */
    func register<T: UICollectionViewCell>(type: T.Type)
    
    /**
     ------------------------------------------------------------------------------------------
     Deque reusable custom row
     ------------------------------------------------------------------------------------------
     - parameter type: class name you want to register
     - parameter rowIndex: row index
     */
    func dequeReusableView<T: UICollectionViewCell>(withType type: T.Type, forRowIndex rowIndex: Int) -> T?
    
    /**
     ------------------------------------------------------------------------------------------
     End refreshing table
     ------------------------------------------------------------------------------------------
     */
    func endRefresh()
}
