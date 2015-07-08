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
   
    var ownerUser:User?
    @NSManaged var owner:String?
    @NSManaged var ownerHand:String?
    @NSManaged var ownerCount:NSNumber?
    @NSManaged var ownerName:String?
    @NSManaged var ownerImage:String?
    
    var enemyUser:User?
    @NSManaged var enemy:String?
    @NSManaged var enemyHand:String?
    @NSManaged var enemyCount:NSNumber?
    @NSManaged var enemyName:String?
    @NSManaged var enemyImage:String?
    
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
        loadOwner(object)
        loadEnemy(object)
        betText = object["betText"] as? String
        finish = object["finish"] as? NSNumber
    }
    
    func loadOwner(object:PFObject) {
        owner = object["owner"] as? String
        ownerName = object["ownerName"] as? String
        ownerImage = object["ownerImage"] as? String
        
        ownerUser = User()
        ownerUser?.facebookId = owner
        ownerUser?.name = ownerName
        ownerUser?.profileImage = ownerImage
    }
    
    func loadEnemy(object:PFObject) {
        enemy = object["enemy"] as? String
        enemyName = object["enemyName"] as? String
        enemyImage = object["enemyImage"] as? String
        
        enemyUser = User()
        enemyUser?.facebookId = enemy
        enemyUser?.name = enemyName
        enemyUser?.profileImage = enemyImage
    }
    
    func getMe() -> User {
        if LoginProvider.user?.facebookId == owner {
            return ownerUser!
        }
        return enemyUser!
    }
    
    func getOponent() -> User {
        if LoginProvider.user?.facebookId == enemy {
            return ownerUser!
        }
        return enemyUser!
    }
    
    func decideWinner() -> String? {
        var sum:Int = (enemyCount!.integerValue + ownerCount!.integerValue)
        if(sum%2 == 0) {
            return owner
        }
        return enemy
    }
    
}
