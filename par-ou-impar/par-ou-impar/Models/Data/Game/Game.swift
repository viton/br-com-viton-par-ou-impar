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
   
    @NSManaged var owner:String?
    @NSManaged var ownerHand:String?
    @NSManaged var ownerCount:NSNumber?
    
    @NSManaged var enemy:String?
    @NSManaged var enemyHand:String?
    @NSManaged var enemyCount:NSNumber?
    
    @NSManaged var betText:String?
    @NSManaged var winner:String?
    @NSManaged var finish:NSNumber?
    
    class func parseClassName() -> String {
        return "Game"
    }
    
    override init() {
        super.init()
    }
    
    init(object:PFObject) {
        super.init()
        owner = object["owner"] as? String
        enemy = object["enemy"] as? String
        betText = object["betText"] as? String
        finish = object["finish"] as? NSNumber
    }
    
    func decideWinner() -> String? {
        var sum:Int = (enemyCount!.integerValue + ownerCount!.integerValue)
        if(sum%2 == 0) {
            return owner
        }
        return enemy
    }
    
}
