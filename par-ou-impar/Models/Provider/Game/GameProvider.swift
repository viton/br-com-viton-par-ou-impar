//
//  GameProvider.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse

protocol GamesCallback:BaseProviderCallback {
    
    func onSuccess(games:Array<Game>)
 
    func onEmptyGamesList()
    
}

protocol CreateGameCallback:BaseProviderCallback {
    
    func onSuccessCreateGame()
    
}

protocol ReplyGameCallback:BaseProviderCallback {
    
    func onSuccessReplyGame(game:Game)
    
}

class GameProvider: NSObject {
 
    class func createGame(game:Game, owner:User, enemy:User, callback:CreateGameCallback) {
        let gameObject = PFObject(className: "Game")
        
        gameObject["owner"] = game.owner
        gameObject["ownerHand"] = game.ownerHand
        gameObject["ownerCount"] = game.ownerCount
        gameObject["ownerName"] = owner.name
        gameObject["ownerImage"] = owner.profileImage
        gameObject["ownerVisualized"] = false
        
        gameObject["enemy"] = game.enemy
        gameObject["enemyHand"] = ""
        gameObject["enemyCount"] = 0
        gameObject["enemyName"] = enemy.name
        gameObject["enemyImage"] = enemy.profileImage
        gameObject["enemyVisualized"] = false
        
        gameObject["finish"] = 0
        gameObject["betText"] = game.betText
        gameObject["winner"] = ""
        
        LoginProvider.register(owner)
        LoginProvider.register(enemy)
        gameObject.saveInBackground({ (result:AnyObject?) -> Void in
            callback.prepareToRespose()
            callback.onSuccessCreateGame()
            GameProvider.sendPush("Você tem um novo jogo. Veja quem te desafiou", facebookId: enemy.facebookId!)
        }, errorBlock:{ (result:String) -> Void in
            callback.prepareToRespose()
            callback.onFailRequest(result)
        }, noConnection:{
            callback.prepareToRespose()
            callback.onFailRequest("Something went wrong. Try again")
        })
    }
    
    class func replyGame(game:Game, callback:ReplyGameCallback?) {
        game["ownerVisualized"] = false
        game["enemyVisualized"] = true
        if callback == nil {
            game.saveInBackground()
            return;
        }
        game.saveInBackground({ (result:AnyObject?) -> Void in
                callback!.prepareToRespose()
                callback!.onSuccessReplyGame(game)
                GameProvider.sendPush("\(game.getMe().name!) respondeu. Quer saber quem ganhou?", facebookId: game.getOponent().facebookId!)
            }, errorBlock:{ (result:String) -> Void in
                callback!.prepareToRespose()
                callback!.onFailRequest(result)
            }, noConnection:{
                callback!.prepareToRespose()
                callback!.onFailRequest("Try Again")
        })
    }
    
    class func getGames(facebookId: String, callback:GamesCallback){
        let ownerQuery = PFQuery(className:"Game")
        ownerQuery.whereKey("owner", equalTo:facebookId)
        
        let enemyQuery = PFQuery(className:"Game")
        enemyQuery.whereKey("enemy", equalTo: facebookId)
        
        let query = PFQuery.orQueryWithSubqueries([ownerQuery, enemyQuery])
        query.orderByAscending("finish")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                var games = Array<Game>()
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        let game = Game(object: object)
                        games.append(game)
                    }
                    print(games.count)
                    callback.prepareToRespose()
                    if games.count == 0 {
                        callback.onEmptyGamesList()
                    }else{
                        callback.onSuccess(games)
                    }
                }
            } else {
                callback.prepareToRespose()
                callback.onConnectionFailToRequest()
            }
        }
    }
    
    class func sendPush(message:String!, facebookId:String!) {
        let push = PFPush()
        push.setMessage(message)
        // Create our Installation query
        if let pushQuery = PFInstallation.query() {
            
            pushQuery.whereKey("userFacebookId", equalTo: facebookId);
            
            // Send push notification to query
            push.setQuery(pushQuery) // Set our Installation query
            push.sendPushInBackground()
        }

    }
    
}
