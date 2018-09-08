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
    
    open override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
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
}
