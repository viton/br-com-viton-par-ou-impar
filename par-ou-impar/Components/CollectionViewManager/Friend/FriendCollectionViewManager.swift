//
//  FriendCollectionViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 9/22/15.
//  Copyright © 2015 Viton. All rights reserved.
//

import UIKit

class FriendCollectionViewManager: CollectionViewManager {

    override func cellClassForItem(item: AnyObject) -> AnyClass {
        if (item as? User) != nil {
            return FriendCollectionViewCell.classForCoder()
        }
        return AddFriendCollectionViewCell.classForCoder()
    }
    
    override func cellClasses() -> Array<AnyClass> {
        return [FriendCollectionViewCell.classForCoder(), AddFriendCollectionViewCell.classForCoder()]
    }
    
    override func setData(item: AnyObject, toCell cell: UICollectionViewCell) {
        if let friendCell = cell as? FriendCollectionViewCell {
            let friend = item as! User
            friendCell.imageView.setImage(url: friend.profileImage!)
            friendCell.selectedView.circle()
            friendCell.selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        }else if let addCell = cell as? AddFriendCollectionViewCell {
            addCell.backgroundContentView.circle()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height-1, height: collectionView.frame.size.height-1)
    }
    
}
