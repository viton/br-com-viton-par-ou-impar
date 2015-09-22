//
//  ChooseFriendsView.swift
//  par-ou-impar
//
//  Created by Taqtile on 9/22/15.
//  Copyright © 2015 Viton. All rights reserved.
//

import UIKit

class ChooseFriendsView: BaseComponentsView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func customSetup() {
        title.text = Messages.message("game.choose.friend.title")
    }

}
