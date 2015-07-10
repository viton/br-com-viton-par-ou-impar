//
//  FriendsTableViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class FriendsTableViewManager: BaseTableViewManager {
    
    override func cellClasses() -> Array<AnyClass> {
        return [FriendTableViewCell.classForCoder()]
    }
    
    override func setData(item: AnyObject, toCell cell: UITableViewCell) {
        if let friendCell = cell as? FriendTableViewCell {
            if let user = item as? User {
                friendCell.nameLabel.text = user.name
                friendCell.friendImageView.setImage(url: user.profileImage!)
                friendCell.friendImageView.circle()
            }
        }
    }
    
}

extension FriendsTableViewManager: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}
