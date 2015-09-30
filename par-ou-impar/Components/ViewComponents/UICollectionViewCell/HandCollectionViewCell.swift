//
//  HandCollectionViewCell.swift
//  par-ou-impar
//
//  Created by Vitor Machado oliveira on 07/07/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class HandCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var handImageView: UIImageView!
    @IBOutlet weak var backgroundSelectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundSelectedView.layer.masksToBounds = false
        backgroundSelectedView.layer.cornerRadius = 10
        backgroundSelectedView.clipsToBounds = true
    }
    
    override var selected: Bool {
        didSet {
            if self.selected {
                backgroundSelectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
            }else {
                backgroundSelectedView.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
}
