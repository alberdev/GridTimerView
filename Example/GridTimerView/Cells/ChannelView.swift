//
//  ChannelView.swift
//  GridTimerView_Example
//
//  Created by Alberto Aznar de los Ríos on 28/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public class ChannelView: UIView {
    
    struct ViewModel {
        var title = "Loading"
        var subtitle = ""
        var image: UIImage?
    }
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var viewModel: ViewModel? {
        didSet {
            channelImageView.image = viewModel?.image
            titleLabel.text = viewModel?.title
            subtitleLabel.text = viewModel?.subtitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupView()
    }
    
    private func commonInit() {
        _ = fromNib()
    }
    
    private func setupView() {
        viewModel = ViewModel()
        channelImageView.layer.cornerRadius = 5
    }
}
