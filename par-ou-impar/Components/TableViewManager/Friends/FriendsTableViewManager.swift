//
//  FriendsTableViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

protocol FriendTableViewManagerDelegate:BaseTableViewManagerDelegate {
    
    func didSelectInviteMoreFriends()
    
}

class FriendsTableViewManager: BaseTableViewManager {
    
    override func cellClasses() -> Array<AnyClass> {
        return [FriendTableViewCell.classForCoder(), InviteMoreFriendsTableViewCell.classForCoder()]
    }
    
    override func setData(item: AnyObject, toCell cell: UITableViewCell) {
        if let friendCell = cell as? FriendTableViewCell {
            if let user = item as? User {
                friendCell.nameLabel.text = user.name
                friendCell.friendImageView.setImage(url: user.profileImage!)
                friendCell.friendImageView.circle()
            }
        }else if let inviteFriendsCell = cell as? InviteMoreFriendsTableViewCell {
            inviteFriendsCell.inviteLabel.text = item.description
        }
    }
    
    override func objectForIndexPath(indexPath: NSIndexPath) -> AnyObject {
        if indexPath.row == 0 {
            return Messages.message("choose.friend.invite.more.friends")
        }
        return data![indexPath.row - 1]
    }
    
    override func cellClassForItem(item: AnyObject) -> AnyClass {
        if let user = item as? User {
            return FriendTableViewCell.classForCoder()
        }
        return InviteMoreFriendsTableViewCell.classForCoder()
    }
    
}

extension FriendsTableViewManager:UITableViewDelegate {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0) {
            let friendsTableDelegate = delegate as! FriendTableViewManagerDelegate
            friendsTableDelegate.didSelectInviteMoreFriends()
        }else {
            var object:AnyObject = data![indexPath.row - 1]
            delegate.didSelectObject(object)
        }
    }
    
}

extension FriendsTableViewManager: UITableViewDataSource {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        }
        return 60
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let friends = data {
            if friends.count > 0 {
                return friends.count + 1
            }
        }
        return 0
    }
    
}
