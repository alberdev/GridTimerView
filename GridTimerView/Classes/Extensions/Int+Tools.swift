//
//  Int+Tools.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 3/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import Foundation

extension Int {
    
    var days: TimeInterval {
        let DAY_IN_SECONDS = 60 * 60 * 24
        let days:Double = Double(DAY_IN_SECONDS) * Double(self)
        return days
    }
    
    func date() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
