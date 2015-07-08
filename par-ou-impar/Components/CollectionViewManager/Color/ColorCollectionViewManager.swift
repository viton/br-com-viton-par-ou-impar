//
//  ColorCollectionViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/7/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class ColorCollectionViewManager: CollectionViewManager {
   
    override func cellClasses() -> Array<AnyClass> {
        return [ColorCollectionViewCell.classForCoder()]
    }
    
    override func setData(item: AnyObject, toCell cell: UICollectionViewCell) {
        if let colorCell = cell as? ColorCollectionViewCell {
            if let color = item as? UIColor {
                colorCell.colorView.backgroundColor = color
                colorCell.colorView.circle()
                colorCell.colorView.setupBorder(1, color: UIColor.blackColor())
            }
        }
    }
    
}

extension ColorCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
    
}
