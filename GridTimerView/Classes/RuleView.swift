//
//  RuleView.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 3/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

public class RuleView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var currentTimeLabel: UILabel?
    private var currentTimeLine: UIView?
    private let ruleTimeInterval: TimeInterval = 60*60 // 60 min
    private let screenSize = UIScreen.main.bounds.size
    
    var ruleDaysFrom = 1 {
        didSet {
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            setupScroll()
            setupCurrentTimeLine()
        }
    }
    
    var ruleDaysTo = 2 {
        didSet {
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            setupScroll()
            setupCurrentTimeLine()
        }
    }
    
    var currentTimeLineDashed = false {
        didSet {
            currentTimeLine?.removeFromSuperview()
            setupCurrentTimeLine()
        }
    }
    var currentTimeLineColor = UIColor.blue {
        didSet {
            currentTimeLine?.removeFromSuperview()
            setupCurrentTimeLine()
        }
    }
    
    var ruleFont = UIFont.systemFont(ofSize: 10, weight: .semibold) {
        didSet {
            for view in scrollView.subviews {
                if let label = view as? UILabel {
                    label.font = ruleFont
                }
            }
        }
    }
    var ruleTextColor = UIColor.lightGray{
        didSet {
            for view in scrollView.subviews {
                if let label = view as? UILabel {
                    label.textColor = ruleTextColor
                }
            }
        }
    }
    var ruleBackgroundColor = UIColor.darkGray {
        didSet {
            backgroundColor = ruleBackgroundColor
        }
    }
    var ruleTicksColor = UIColor.white {
        didSet {
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            setupScroll()
            setupCurrentTimeLine()
        }
    }
    var timerFont = UIFont.systemFont(ofSize: 12, weight: .semibold) {
        didSet {
            currentTimeLabel?.font = timerFont
        }
    }
    var timerColor = UIColor.blue {
        didSet {
            currentTimeLabel?.backgroundColor = timerColor
        }
    }
    var timerTextColor = UIColor.white {
        didSet {
            currentTimeLabel?.textColor = timerTextColor
        }
    }
    var scrollDate: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupScroll()
        setupCurrentTimeLabel()
        setupCurrentTimeLine()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupScroll()
        setupCurrentTimeLabel()
        setupCurrentTimeLine()
    }
    
    private func commonInit() {
        _ = fromNib()
    }
    
    private func setupScroll() {
        
        backgroundColor = ruleBackgroundColor
        
        var initialDate = Date.add(days: -ruleDaysFrom).timeIntervalSince1970
        
        var j = 0
        for i in 0 ..< 20 * 24 * (ruleDaysFrom + ruleDaysTo) + 1 {
            let timeXPos = CGFloat(i)*(ruleWidth/20)
            let timeTick = UIView(frame: CGRect(x: timeXPos, y: 0, width: 0.5, height: j == 10 ? 15 : 10))
            timeTick.backgroundColor = ruleTicksColor
            scrollView.addSubview(timeTick)
            
            if j == 10 {
                j = 1
            } else {
                j += 1
            }
        }
        
        for i in 0 ..< 24 * (ruleDaysFrom + ruleDaysTo) + 1 {
            let timeXPos = CGFloat(i)*ruleWidth 
            let timeLabel = UILabel(frame: CGRect(x: timeXPos - 25, y: 7, width: 50, height: 40))
            timeLabel.font = ruleFont
            timeLabel.text = Date(timeIntervalSince1970: initialDate).format(dateFormat: "HH:mm")
            timeLabel.textColor = ruleTextColor
            timeLabel.textAlignment = .center
            scrollView.addSubview(timeLabel)
            
            let timeTick = UIView(frame: CGRect(x: timeXPos, y: 0, width: 0.5, height: 20))
            timeTick.backgroundColor = ruleTicksColor
            scrollView.addSubview(timeTick)
            
            initialDate += ruleTimeInterval
        }
    }
    
    private func setupCurrentTimeLabel() {
        
        currentTimeLabel = UILabel(frame: CGRect(x: screenSize.width/2 - 25, y: 5, width: 50, height: 30))
        currentTimeLabel?.font = timerFont
        currentTimeLabel?.textAlignment = .center
        currentTimeLabel?.text = Date().format(dateFormat: "HH:mm")
        currentTimeLabel?.backgroundColor = timerColor
        currentTimeLabel?.textColor = timerTextColor
        currentTimeLabel?.layer.cornerRadius = 5
        currentTimeLabel?.clipsToBounds = true
        addSubview(currentTimeLabel!)
    }
    
    private func setupCurrentTimeLine() {
        let xPos = xPosition(byDate: Date(), fromInitDate: Date.add(days: -ruleDaysFrom))
        currentTimeLine = UIView(frame: CGRect(x: xPos, y: frame.size.height, width: 1, height: screenSize.height))
        if currentTimeLineDashed {
            currentTimeLine?.addDashedBorder(width: nil, height: nil, lineWidth: 0.25, lineDashPattern:  [6,3], strokeColor: currentTimeLineColor, fillColor: .clear)
        } else {
            currentTimeLine?.backgroundColor = currentTimeLineColor
        }
        scrollView.addSubview(currentTimeLine!)
    }
    
    func updateContentOffset(x: CGFloat) {
        scrollView.contentOffset = CGPoint(x: x, y: 0)
        let scrollTimeInterval = TimeInterval(x + screenSize.width/2)*ruleTimeInterval/TimeInterval(ruleWidth) + Date.today().timeIntervalSince1970
        scrollDate = Date(timeIntervalSince1970: scrollTimeInterval)
        currentTimeLabel?.text = scrollDate?.format(dateFormat: "HH:mm")
    }
}
