//
//  GameProvider.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse

class GameProvider: NSObject {
 
    class func createGame(game:Game, owner:User, enemy:User) {
        let gameObject = PFObject(className: "Game")
        
        gameObject["owner"] = game.owner
        gameObject["ownerHand"] = game.ownerHand
        gameObject["ownerCount"] = game.ownerHand
        
        gameObject["enemy"] = game.enemy
        gameObject["enemyHand"] = ""
        gameObject["enemyCount"] = 0
        
        gameObject["finish"] = 0
        gameObject["betText"] = game.betText
        gameObject["winner"] = ""
        
        LoginProvider.register(owner)
        LoginProvider.register(enemy)
        gameObject.saveInBackground({ (result:AnyObject?) -> Void in
            
            }, errorBlock:{ (result:String) -> Void in
                
            }, noConnection:{
                
        })
    }
    
    class func replyGame(game:Game) {
        game.saveInBackground({ (result:AnyObject?) -> Void in
            
            }, errorBlock:{ (result:String) -> Void in
                
            }, noConnection:{
                
        })
    }
    
    class func getGames(facebookId: String){
        var query = PFQuery(className:"Game")
        query.whereKey("owner", equalTo:facebookId)
        query.whereKey("enemy", equalTo: facebookId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                var games = Array<Game>()
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                        let game = Game(object: object)
                        games.append(game)
                        println(game.betText)
                    }
                }
            } else {
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }
    
    
}
