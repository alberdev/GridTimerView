//
//  HeaderCollectionViewCell.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 5/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

protocol GridItemViewDelegate: class {
    func gridItemView(gridItemView: GridItemView, didSelect selected: Bool)
}

open class GridItemView: UICollectionViewCell {
    
    weak var delegate: GridItemViewDelegate?
    var indexPath: IndexPath?
    var highlitedItems = 0
    
    open override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        hideSubviews()
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        delegate?.gridItemView(gridItemView: self, didSelect: true)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
    }
    
    public func hideSubviews() {
        for view in contentView.subviews[0].subviews {
            view.isHidden = true
        }
    }
    
    public func showSubviews() {
        for view in contentView.subviews[0].subviews {
            view.isHidden = false
        }
    }
}
