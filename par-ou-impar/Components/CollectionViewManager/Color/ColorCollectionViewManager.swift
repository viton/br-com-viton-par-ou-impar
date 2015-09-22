//
//  ColorCollectionViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/7/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class ColorCollectionViewManager: CollectionViewManager {
   
    override func cellClassForItem(item: AnyObject) -> AnyClass {
        if (item as? String != nil) {
            return AllColorsCollectionViewCell.classForCoder()
        }
        return ColorCollectionViewCell.classForCoder()
    }
    
    override func cellClasses() -> Array<AnyClass> {
        return [ColorCollectionViewCell.classForCoder(), AllColorsCollectionViewCell.classForCoder()]
    }
    
    override func setData(item: AnyObject, toCell cell: UICollectionViewCell) {
        if let colorCell = cell as? ColorCollectionViewCell {
            if let color = item as? UIColor {
                colorCell.colorView.backgroundColor = color
                colorCell.colorView.setupBorder(2, color: UIColor.whiteColor().colorWithAlphaComponent(0.8))
                colorCell.colorView.circle()
            }
        }else if let allColorsCell = cell as? AllColorsCollectionViewCell {
            allColorsCell.topView.backgroundColor = ColorProvider.getAllColors()[0]
            allColorsCell.topView.circle()
            allColorsCell.leftView.backgroundColor = ColorProvider.getAllColors()[1]
            allColorsCell.leftView.circle()
            allColorsCell.rightView.backgroundColor = ColorProvider.getAllColors()[2]
            allColorsCell.rightView.circle()
            allColorsCell.bottomView.backgroundColor = ColorProvider.getAllColors()[3]
            allColorsCell.bottomView.circle()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
}
