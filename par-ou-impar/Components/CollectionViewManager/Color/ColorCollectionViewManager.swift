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
                colorCell.colorView.setupBorder(2, color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.6))
                colorCell.colorView.circle()
            }
        }
    }
    
}

extension ColorCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
}
