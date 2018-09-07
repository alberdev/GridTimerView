//
//  MainViewController+Tools.swift
//  GridTimerView_Example
//
//  Created by Alberto Aznar de los Ríos on 7/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

extension MainViewController {
    
    public func channelAt(_ index: Int) -> Channel? {
        return channels.element(at: index)
    }
    
    public func eventAt(_ indexPath: IndexPath) -> Event? {
        return channelAt(indexPath.section)?.events.element(at: indexPath.row)
    }
}
