//
//  HeaderCollectionViewCell.swift
//  TableTimer
//
//  Created by Alberto Aznar de los Ríos on 5/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

protocol GridCollectionViewCellDelegate: class {
    func gridCollectionViewCell(gridCollectionViewCell: GridCollectionViewCell, didSelect selected: Bool)
}

public class GridCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: GridCollectionViewCellDelegate?
    var indexPath: IndexPath?
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isHighlighted = true
        delegate?.gridCollectionViewCell(gridCollectionViewCell: self, didSelect: true)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isHighlighted = false
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isHighlighted = false
    }
}
