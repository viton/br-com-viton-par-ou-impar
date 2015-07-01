//
//  Game.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse

class Game: PFObject, PFSubclassing {
   
    var owner:User?
    var ownerHand:Hand?
    var enemy:User?
    var enemyHand:Hand?
    
    var betText:String?
    var winner:User?
    var finish:Bool?
    
    class func parseClassName() -> String {
        return "Game"
    }
    
}
