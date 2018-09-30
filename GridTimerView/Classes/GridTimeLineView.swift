//
//  GridTimeLineView.swift
//  GridTimerView
//
//  Created by Alberto Aznar de los Ríos on 10/9/18.
//

import UIKit

public class GridTimeLineView: UICollectionViewCell {
    
    var selectedItemColor: UIColor?
    var unselectedItemColor: UIColor?
    
    /// Is true when cell is highlighted
    /// Used only to save the current state
    var isOn = false {
        didSet {
            backgroundColor = isOn ? selectedItemColor : unselectedItemColor
        }
    }
}
