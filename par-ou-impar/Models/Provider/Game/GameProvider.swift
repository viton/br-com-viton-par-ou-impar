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
        
        gameObject["enemy"] = game.enemy
        gameObject["enemyHand"] = ""
        gameObject["enemyCount"] = 0
        gameObject["enemyName"] = enemy.name
        gameObject["enemyImage"] = enemy.profileImage
        
        gameObject["finish"] = 0
        gameObject["betText"] = game.betText
        gameObject["winner"] = ""
        
        LoginProvider.register(owner)
        LoginProvider.register(enemy)
        gameObject.saveInBackground({ (result:AnyObject?) -> Void in
            callback.prepareToRespose()
            callback.onSuccessCreateGame()
        }, errorBlock:{ (result:String) -> Void in
            callback.prepareToRespose()
            callback.onFailRequest(result)
        }, noConnection:{
            callback.prepareToRespose()
            callback.onFailRequest("Something went wrong. Try again")
        })
    }
    
    class func replyGame(game:Game, callback:ReplyGameCallback) {
        game.saveInBackground({ (result:AnyObject?) -> Void in
                callback.prepareToRespose()
                callback.onSuccessReplyGame(game)
            
                var push = PFPush()
                push.setMessage("Seu adversário respondeu ao seu jogo. Veja quem ganhou!")
                // Create our Installation query
            if let pushQuery = PFInstallation.query() {
                
                pushQuery.whereKey("userFacebookId", equalTo: game.getOponent().facebookId!);
            
                // Send push notification to query
                push.setQuery(pushQuery) // Set our Installation query
                push.sendPushInBackground()
            }
            
            }, errorBlock:{ (result:String) -> Void in
                callback.prepareToRespose()
                callback.onFailRequest(result)
            }, noConnection:{
                callback.prepareToRespose()
                callback.onFailRequest("Try Again")
        })
    }
    
    class func getGames(facebookId: String, callback:GamesCallback){
        var query = PFQuery(className:"Game")
        query.whereKey("owner", equalTo:facebookId)
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
                    self.getGamesWithMe(facebookId, myGames: games, callback:callback)
                }
            } else {
                callback.prepareToRespose()
                callback.onConnectionFailToRequest()
            }
        }
    }
    
    class func getGamesWithMe(facebookId:String, myGames:Array<Game>, callback:GamesCallback) {
        var query = PFQuery(className:"Game")
        query.whereKey("enemy", equalTo: facebookId)
        query.orderByAscending("finish")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                var games:Array<Game> = Array(myGames)
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        let game = Game(object: object)
                        games.append(game)
                    }
                }
                callback.prepareToRespose()
                if games.count == 0 {
                    callback.onEmptyGamesList()
                }else{
                    callback.onSuccess(games)
                }
            } else {
                callback.prepareToRespose()
                callback.onConnectionFailToRequest()
            }
        }
    }
    
    
}
