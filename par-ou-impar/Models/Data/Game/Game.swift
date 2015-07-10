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
        winner = object["winner"] as? String
    }
    
    func loadOwner(object:PFObject) {
        owner = object["owner"] as? String
        ownerName = object["ownerName"] as? String
        ownerImage = object["ownerImage"] as? String
        ownerCount = object["ownerCount"] as? NSNumber
        ownerHand = object["ownerHand"] as? String
        
        ownerUser = User()
        ownerUser?.facebookId = owner
        ownerUser?.name = ownerName
        ownerUser?.profileImage = ownerImage
    }
    
    func loadEnemy(object:PFObject) {
        enemy = object["enemy"] as? String
        enemyName = object["enemyName"] as? String
        enemyImage = object["enemyImage"] as? String
        enemyCount = object["enemyCount"] as? NSNumber
        enemyHand = object["enemyHand"] as? String
        
        enemyUser = User()
        enemyUser?.facebookId = enemy
        enemyUser?.name = enemyName
        enemyUser?.profileImage = enemyImage
    }
    
    func getMe() -> User {
        if amIOwner() {
            return ownerUser!
        }
        return enemyUser!
    }
    
    func getMyHand() -> FightHand {
        if amIOwner() {
            return FightHandProvider.find(ownerHand!)
        }
        return FightHandProvider.find(enemyHand!)
    }
    
    func getOpponentHand() -> FightHand {
        if !amIOwner() {
            return FightHandProvider.find(ownerHand!)
        }
        return FightHandProvider.find(enemyHand!)
    }
    
    func getOponent() -> User {
        if !amIOwner() {
            return ownerUser!
        }
        return enemyUser!
    }
    func getMyCount() -> Int {
        if amIOwner() {
            return ownerCount!.integerValue
        }
        return enemyCount!.integerValue
    }
    
    func getOpponentCount() -> Int {
        if amIOwner() {
            return enemyCount!.integerValue
        }
        return ownerCount!.integerValue
    }
    
    
    func decideWinner() -> String? {
        var sum:Int = (enemyCount!.integerValue + ownerCount!.integerValue)
        if(sum%2 == 0) {
            return owner
        }
        return enemy
    }
    
    private func amIOwner() -> Bool {
        if LoginProvider.user?.facebookId == owner {
            return true
        }
        return false
    }
    
    func getStatus() -> String {
        if(finish!.boolValue == false) {
            if(getMe().facebookId == owner) {
                return "Waiting for opponent"
            }else {
                return "Ready for Fight"
            }
        }
        return "Finish"
    }
    
    func getWinnerText() -> String {
        if(winner == getMe().facebookId!) {
            return "YOU WIN"
        }
        return "YOU LOOSE"
    }
    
    func amIWinner() -> Bool {
        return winner == getMe().facebookId!
    }
    
}
