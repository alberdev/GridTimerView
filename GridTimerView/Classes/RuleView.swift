//
//  RuleView.swift
//  TableTimer
//
//  Created by Alberto Aznar de los Ríos on 3/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class RuleView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    private var currentTimeLabel: UILabel?
    private let ruleWidth: CGFloat = 96.05
    private let ruleTimeInterval: TimeInterval = 60*60 // 60 min
    private let screenSize = UIScreen.main.bounds.size
    
    var ruleDaysFrom = 1
    var ruleDaysTo = 2
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
    var ruleColor = UIColor.white {
        didSet {
            guard let patternImage = UIImage(named: "PatternRule")?.maskWithColor(color: ruleColor) else { return }
            scrollView.backgroundColor = UIColor(patternImage: patternImage)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupScroll()
        setupCurrentTimeLabel()
    }
    
    private func commonInit() {
        _ = fromNib()
    }
    
    private func setupScroll() {
        
        let podBundle = Bundle(for: self.classForCoder)
        let image = UIImage(named: "PatternRule", in: podBundle, compatibleWith: nil)
        guard let patternImage = image?.maskWithColor(color: ruleColor) else { return }
        
        scrollView.contentSize = CGSize(width: ruleWidth*24*CGFloat(ruleDaysTo), height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(patternImage: patternImage)
        
        backgroundColor = ruleBackgroundColor
        
        var initialDate = Date.add(days: -ruleDaysFrom).timeIntervalSince1970
        for i in 0 ..< 24*ruleDaysTo {
            let timeXPos = CGFloat(i)*ruleWidth 
            let timeLabel = UILabel(frame: CGRect(x: timeXPos - 25, y: 7, width: 50, height: 40))
            timeLabel.font = ruleFont
            timeLabel.text = Date(timeIntervalSince1970: initialDate).format(dateFormat: "HH:mm")
            timeLabel.textColor = ruleTextColor
            timeLabel.textAlignment = .center
            scrollView.addSubview(timeLabel)
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
    
    func updateContentOffset(x: CGFloat) {
        scrollView.contentOffset = CGPoint(x: x, y: 0)
        let scrollTimeInterval = TimeInterval(x + screenSize.width/2)*ruleTimeInterval/TimeInterval(ruleWidth) + Date.today().timeIntervalSince1970
        scrollDate = Date(timeIntervalSince1970: scrollTimeInterval)
        currentTimeLabel?.text = scrollDate?.format(dateFormat: "HH:mm")
    }
}
