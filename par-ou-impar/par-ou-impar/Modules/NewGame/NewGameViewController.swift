//
//  NewGameViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class NewGameViewController: BaseViewController {

    var chooseFriendViewController:ChooseFriendViewController?
    var friend:User?
    var me:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Novo"
        navigationController?.navigationBarHidden = false
        loadMe()
    }
    
    func loadMe() {
        println(FBSDKAccessToken.currentAccessToken().userID)
        let meRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        meRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if error == nil {
                let dictResult = result as! NSDictionary
                self.me = User()
                self.me?.facebookId = FBSDKAccessToken.currentAccessToken().userID
                self.me?.name = dictResult["name"]! as? String
                self.me?.profileImage = String(format: "http://graph.facebook.com/%@/picture?type=normal", FBSDKAccessToken.currentAccessToken().userID)
            } else {
                println("\(error)")
            }
        })
    }

    @IBAction func chooseFriendAction(sender: AnyObject) {
        chooseFriendViewController = ChooseFriendViewController()
        presentViewController(chooseFriendViewController!, animated: true, completion: {
            
        })
    }
    
    @IBAction func createGameAction(sender: AnyObject) {
        let game = Game()
        game.enemy = me
        game.owner = me
        game.ownerHand = getHand()
        game.betText = "vamos fazer um teste"
        GameProvider.createGame(game)
        
    }
    
    func getHand() -> Hand {
        let hand = Hand()
        hand.count = 1
        hand.imagePrefixName = "img_hand_"
        return hand
    }
    
}
