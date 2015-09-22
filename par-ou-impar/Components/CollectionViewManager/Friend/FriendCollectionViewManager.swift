//
//  FriendCollectionViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 9/22/15.
//  Copyright © 2015 Viton. All rights reserved.
//

import UIKit

class FriendCollectionViewManager: CollectionViewManager {

//    override func cellClassForItem(item: AnyObject) -> AnyClass {
//        return ColorCollectionViewCell.classForCoder()
//    }
    
    override func cellClasses() -> Array<AnyClass> {
        return [FriendCollectionViewCell.classForCoder()]
    }
    
    override func setData(item: AnyObject, toCell cell: UICollectionViewCell) {
        if let friendCell = cell as? FriendCollectionViewCell {
            let friend = item as! User
            friendCell.imageView.setImage(url: friend.profileImage!)
        }
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
}
