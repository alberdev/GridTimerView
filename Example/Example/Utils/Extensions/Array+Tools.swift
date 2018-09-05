//
//  AppDelegate.swift
//  GridTimerView
//
//  Created by alberdev on 09/05/2018.
//  Copyright (c) 2018 alberdev. All rights reserved.
//

import Foundation

public extension Array {
    
    public func element(at index: Int) -> Element? {
        return index < self.count && index >= 0 ? self[index] : nil
    }
}
