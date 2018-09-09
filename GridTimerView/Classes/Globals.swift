//
//  Globals.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 9/9/18.
//

import Foundation

let ruleWidth: CGFloat = 96.05 // in 3600s

func xPosition(byDate date: Date, fromInitDate initDate: Date) -> CGFloat {
    let ruleInitialDate = initDate.timeIntervalSince1970
    let eventInitialDate = date.timeIntervalSince1970
    let secondForDifference = Int(eventInitialDate - ruleInitialDate)
    return floatForTime(seconds: secondForDifference)
}

func floatForTime(seconds: Int) -> CGFloat {
    let pointsPerSecond: CGFloat = CGFloat(ruleWidth)/3600
    return CGFloat(seconds) * pointsPerSecond
}
