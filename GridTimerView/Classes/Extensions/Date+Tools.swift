//
//  Date+Tools.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 3/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import Foundation

extension Date {
    
    static func generateFrom(text: String?, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        guard let text = text else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: text)
    }
    
    func format(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}

extension Date {
    
    var dayNumber: Int {
        let cal = NSCalendar.current
        let component = cal.component(.day, from: self)
        return Int(component)
    }
    
    var year: Int {
        let cal = NSCalendar.current
        let component = cal.component(.year, from: self)
        return Int(component)
    }
    
    static public func today() -> Date {
        let cal = NSCalendar.current
        let components = cal.dateComponents([.year, .month, .day], from: Date())
        let today = cal.date(from: components)
        return today!
    }
    
    static public func add(days: Int) -> Date {
        return Date.today().addingTimeInterval(days.days)
    }
}
