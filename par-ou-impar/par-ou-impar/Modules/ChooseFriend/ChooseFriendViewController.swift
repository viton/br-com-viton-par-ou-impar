//
//  ChooseFriendViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class ChooseFriendViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        modalPresentationStyle = UIModalPresentationStyle.PageSheet
        requestFriends()
    }
    
    func requestFriends() {
        println(FBSDKAccessToken.currentAccessToken().userID)
        let pictureRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: nil)
        pictureRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if error == nil {
                let dataDict:NSDictionary = result as! NSDictionary
                let friendsArray:Array<NSDictionary> = dataDict.objectForKey("data")! as! Array<NSDictionary>
                
                for dict in friendsArray {
                    println(dict.objectForKey("name"))
                    println(dict.objectForKey("id"))
                }
                println(result)
            } else {
                println("\(error)")
            }
        })
    }
    
}
