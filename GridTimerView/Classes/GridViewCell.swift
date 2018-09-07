//
//  HeaderCollectionViewCell.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 5/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit

protocol GridViewCellDelegate: class {
    func gridViewCell(gridViewCell: GridViewCell, didSelect selected: Bool)
}

open class GridViewCell: UICollectionViewCell {
    
    weak var delegate: GridViewCellDelegate?
    var indexPath: IndexPath?
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isHighlighted = true
        delegate?.gridViewCell(gridViewCell: self, didSelect: true)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isHighlighted = false
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isHighlighted = false
    }
}
