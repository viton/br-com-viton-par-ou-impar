//
//  HandCountCollectionViewCell.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class HandCountCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countLabel: UILabel!
    
    override var selected: Bool {
        didSet {
            if self.selected {
                countLabel.textColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
            }else {
                countLabel.textColor = UIColor.whiteColor()
            }
        }
    }
    
}
