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
    @IBOutlet weak var circleView: UIView!
    
    override var selected: Bool {
        didSet {
            if self.selected {
                println("Selected \(countLabel.text)")
                countLabel.textColor = UIColor.redColor()
            }else {
                countLabel.textColor = UIColor.whiteColor()
            }
        }
    }
    
}
