//
//  SectionCollectionViewCell.swift
//  GridTimerView
//
//  Created by Alberto Aznar on 3/9/18.
//  Copyright © 2018 Alberto Aznar. All rights reserved.
//

import UIKit
import GridTimerView

class ChannelItemView: GridItemView {

    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cellContentView: UIView!
    
    var source: ChannelItemViewSource? {
        didSet {
            fill(source: source)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                cellContentView.backgroundColor = Colors.White2
            } else {
                cellContentView.backgroundColor = .white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        channelImageView.layer.cornerRadius = 5
    }
    
    // ---------------------------------------------------------
    // Private
    // ---------------------------------------------------------

    private func fill(source: ChannelItemViewSource?) {
        channelImageView.image = source?.image
        titleLabel.text = source?.title
        subtitleLabel.text = source?.subtitle
    }
}
