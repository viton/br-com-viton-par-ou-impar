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
                setupColorsView(color, view: colorCell.colorView);
            }
        }else if let allColorsCell = cell as? AllColorsCollectionViewCell {
            setupColorsView(ColorProvider.getAllColors()[0], view: allColorsCell.topView);
            setupColorsView(ColorProvider.getAllColors()[1], view: allColorsCell.leftView);
            setupColorsView(ColorProvider.getAllColors()[2], view: allColorsCell.rightView);
            setupColorsView(ColorProvider.getAllColors()[3], view: allColorsCell.bottomView);
        }
    }
    
    func setupColorsView(color:UIColor, view:UIView){
        view.backgroundColor = color
        view.circle()
        view.setupBorder(1, color: UIColor.whiteColor().colorWithAlphaComponent(0.8))
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
}
