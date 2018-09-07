//
//  Configuration.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 6/9/18.
//

import Foundation

public struct GridTimerConfiguration {
    
    public var ruleFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
    public var ruleTextColor = UIColor.lightGray
    public var ruleDaysFrom = 1
    public var ruleDaysTo = 2
    public var ruleBackgroundColor = UIColor.darkGray
    public var ruleColor = UIColor.white
    public var timerFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
    public var timerColor = UIColor.blue
    public var timerTextColor = UIColor.white
    public var lineColor = UIColor.blue
    public var selectedItemColor = UIColor.blue
    public var unselectedItemColor = UIColor.lightGray
    
    public init() {}
}
