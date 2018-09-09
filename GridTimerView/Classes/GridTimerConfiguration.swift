//
//  Configuration.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 6/9/18.
//

import Foundation

public struct GridTimerConfiguration {
    
    /// Font for timer labels in rule
    public var ruleFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
    
    /// Color for timer labels in rule
    public var ruleTextColor = UIColor.lightGray
    
    /// Days before today for initial time
    public var ruleDaysFrom = 1
    
    /// Days after today for end time
    public var ruleDaysTo = 2
    
    /// Rule image color
    public var ruleBackgroundColor = UIColor.darkGray
    
    /// Rule background color
    public var ruleColor = UIColor.white
    
    /// Font used in current time
    public var timerFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    /// Background color used in current time
    public var timerColor = UIColor.blue
    
    /// Text color used in current time
    public var timerTextColor = UIColor.white
    
    /// Selected date line color
    public var lineColor = UIColor.blue
    
    /// Current date line color
    public var timeLineColor = UIColor.blue
    
    /// Selected highlight color on event
    public var selectedItemColor = UIColor.blue
    
    /// Unselected color on event
    public var unselectedItemColor = UIColor.lightGray
    
    public init() {}
}
