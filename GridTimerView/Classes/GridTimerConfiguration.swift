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
    
    /// Rule background color
    public var ruleBackgroundColor = UIColor.darkGray
    
    /// Rule ticks color
    public var ruleTicksColor = UIColor.white
    
    /// Font used in current time
    public var timerFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    /// Background color used in current time
    public var timerColor = UIColor.blue
    
    /// Text color used in current time
    public var timerTextColor = UIColor.white
    
    /// Selected date line color
    public var lineColor = UIColor.blue
    
    /// Current date line color
    public var currentTimeLineColor = UIColor.blue
    
    /// Current date line color
    public var currentTimeLineDashed = false
    
    /// Selected highlight color on event
    public var selectedItemColor = UIColor.blue
    
    /// Unselected color on event
    public var unselectedItemColor = UIColor.lightGray
    
    /// Selected highlight color when row cell touched
    public var selectedColorOnTouch = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    
    /// Row separation
    public var rowSeparation: CGFloat = 10.0
    
    /// Enable refresh
    public var enableRefresh: Bool = false
    
    public init() {}
}
