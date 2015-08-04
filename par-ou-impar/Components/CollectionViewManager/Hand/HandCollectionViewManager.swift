//
//  HandCollectionViewManager.swift
//  par-ou-impar
//
//  Created by Vitor Machado oliveira on 07/07/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class HandCollectionViewManager: CollectionViewManager {
   
    override func cellClasses() -> Array<AnyClass> {
        return [HandCollectionViewCell.classForCoder()]
    }
    
    override func setData(item: AnyObject, toCell cell: UICollectionViewCell) {
        if let fightHandCell = cell as? HandCollectionViewCell {
            if let fightHand = item as? FightHand {
                fightHandCell.handImageView.image = UIImage(named: (fightHand.imagePrefix! + "5"))
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height*0.8, height: collectionView.frame.size.height)
    }
   
}
