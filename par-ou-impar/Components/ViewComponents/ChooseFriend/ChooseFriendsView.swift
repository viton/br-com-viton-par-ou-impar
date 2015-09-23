//
//  ChooseFriendsView.swift
//  par-ou-impar
//
//  Created by Taqtile on 9/22/15.
//  Copyright © 2015 Viton. All rights reserved.
//

import UIKit

protocol ChooseFriendViewDelegate {
 
    func chooseFriendViewDidSelectFriend(friend: User?);
    
    func chooseFriendViewDidSelectSearch();
    
}

class ChooseFriendsView: BaseComponentsView {

    var delegate: ChooseFriendViewDelegate!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var friendsCollectionViewManager: CollectionViewManager?
    
    override func customSetup() {
        title.text = Messages.message("game.choose.friend.title")

//        [collectionView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        friendsCollectionViewManager = FriendCollectionViewManager(collectionView: collectionView, delegate:self)
    }
    
    func setupWithFriends(friends: Array<AnyObject>) {
        var data = Array<AnyObject>()
        data.append("")
        data += friends
        friendsCollectionViewManager?.updateWithData(data)
    }

}

extension ChooseFriendsView:BaseTableViewManagerDelegate {
   
    func didSelectObject(object: AnyObject) {
        if(object as? User != nil){
            delegate.chooseFriendViewDidSelectFriend(object as? User)
        }else{
            delegate.chooseFriendViewDidSelectFriend(nil)
            delegate.chooseFriendViewDidSelectSearch()
        }
    }
    
}
