//
//  FriendsTableViewManager.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

protocol FriendsTableManagerDelegate {

    func didSelectFriend(friend:User?)
}

class FriendsTableViewManager: BaseTableViewManager, UITableViewDelegate {

    var delegate:FriendsTableManagerDelegate?
    
    init(tableView: UITableView, delegate:FriendsTableManagerDelegate) {
        self.delegate = delegate
        super.init(tableView: tableView)
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var user = data![indexPath.row] as? User
        delegate?.didSelectFriend(user)
    }
    
}
