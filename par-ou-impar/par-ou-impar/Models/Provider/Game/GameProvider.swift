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
 
    class func createGame(game:Game) {
        let gameObject = PFObject(className: "Game")
        gameObject["owner"] = game.owner
        gameObject["ownerHand"] = game.ownerHand
        gameObject["enemy"] = game.enemy
        gameObject["finish"] = false
        gameObject["betText"] = game.betText
        gameObject.saveInBackground({ (result:AnyObject?) -> Void in
            
            }, errorBlock:{ (result:String) -> Void in
                
            }, noConnection:{
                
        })
    }
    
}
