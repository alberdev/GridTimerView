//
//  SectionCollectionViewCell.swift
//  TableTimer
//
//  Created by Alberto Aznar de los Ríos on 3/9/18.
//  Copyright © 2018 Alberto Aznar de los Ríos. All rights reserved.
//

import UIKit

class SectionCollectionViewCell: GridCollectionViewCell {

    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cellContentView: UIView!
    
    var source: SectionCollectionViewCellItem? {
        didSet {
            fill(source: source)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                cellContentView.backgroundColor = Colors.White
            } else {
                cellContentView.backgroundColor = .white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionImageView.layer.cornerRadius = 5
    }
    
    // ---------------------------------------------------------
    // Private
    // ---------------------------------------------------------

    private func fill(source: SectionCollectionViewCellItem?) {
        sectionImageView.image = source?.image
        titleLabel.text = source?.title
        subtitleLabel.text = source?.subtitle
    }
}
