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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.circle()
        selectedView.setupBorder(1, color: UIColor.blackColor())
    }
    
    override var selected: Bool {
        didSet {
            if self.selected {
                selectedView.backgroundColor = UIColor.blackColor()
            }else {
                selectedView.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
}
