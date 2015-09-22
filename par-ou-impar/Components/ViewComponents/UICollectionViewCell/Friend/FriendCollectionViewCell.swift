//
//  FriendCollectionViewCell.swift
//  par-ou-impar
//
//  Created by Taqtile on 9/22/15.
//  Copyright © 2015 Viton. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedView: UIView!
 
    override var selected: Bool {
        didSet {
            selectedView.hidden = !self.selected
        }
    }
    
}
