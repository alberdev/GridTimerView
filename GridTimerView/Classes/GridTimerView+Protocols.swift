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
     - returns: number of rows
     */
    func numberOfRows(inGridTimerView gridTimerView: GridTimerView) -> Int
    
    /**
     ------------------------------------------------------------------------------------------
     Returns height of custom row in the table (no events)
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - returns: height of custom row
     */
    func heightForRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat
    
    /**
     ------------------------------------------------------------------------------------------
     Returns height of highlighted items
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - returns: height of highlighted items
     */
    func heightForTimelineRow(inGridTimerView gridTimerView: GridTimerView) -> CGFloat
    
    /**
     ------------------------------------------------------------------------------------------
     Returns number of items in row
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter rowIndex: row index
     - returns: number of items in row
     */
    func gridTimerView(gridTimerView: GridTimerView, numberOfItemsAtRowIndex rowIndex: Int) -> Int
    
    /**
     ------------------------------------------------------------------------------------------
     Returns custom row view (no event)
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter itemIndex: item index
     - parameter rowIndex: row index
     - returns: row view
     */
    func gridTimerView(gridTimerView: GridTimerView, viewForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> UIView
    
    /**
     ------------------------------------------------------------------------------------------
     Returns initial event date
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter itemIndex: item index
     - parameter rowIndex: row index
     - returns: initial date
     */
    func gridTimerView(gridTimerView: GridTimerView, endTimeForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date
    
    /**
     ------------------------------------------------------------------------------------------
     Returns end event date
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter itemIndex: item index
     - parameter rowIndex: row index
     - returns: end date
     */
    func gridTimerView(gridTimerView: GridTimerView, startTimeForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> Date
    
    /**
     ------------------------------------------------------------------------------------------
     Returns color by event in row.
     If returns nil, `selectedItemColor` in configuration will be the selected color
     ------------------------------------------------------------------------------------------
     - parameter gridTimerView: current gridTimerView
     - parameter itemIndex: item index
     - parameter rowIndex: row index
     - returns: event color
     */
    func gridTimerView(gridTimerView: GridTimerView, colorForItemIndex itemIndex: Int, inRowIndex rowIndex: Int) -> UIColor?
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
    func gridTimerView(gridTimerView: GridTimerView, didSelectRowAtItemIndex itemIndex: Int, inRowIndex rowIndex: Int)
    
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
    
    func gridTimerView(gridTimerView: GridTimerView, didSelectRowAtIndex rowIndex: Int) {
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
    func viewForRowIndex(rowIndex: Int) -> UIView?
    
    // Register your own view for row is needed for reuse in table
    // func register<T: UICollectionViewCell>(type: T.Type) 
    // Deque reusable custom view
    // func dequeReusableView<T: UICollectionViewCell>(withType type: T.Type, forRowIndex rowIndex: Int) -> T?
    
    /**
     ------------------------------------------------------------------------------------------
     End refreshing table
     ------------------------------------------------------------------------------------------
     */
    func endRefresh()
    
    /**
     ------------------------------------------------------------------------------------------
     Reload collection view data
     ------------------------------------------------------------------------------------------
     */
    func reloadGridData()
    
    /**
     ------------------------------------------------------------------------------------------
     Reload collection view data for row index
     ------------------------------------------------------------------------------------------
     */
    func reloadGridRowIndex(_ rowIndex: Int)
}
