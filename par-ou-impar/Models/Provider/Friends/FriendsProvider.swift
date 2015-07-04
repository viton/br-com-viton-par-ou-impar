//
//  FriendsProvider.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import Foundation
import FBSDKCoreKit

protocol FriendsCallback: BaseProviderCallback {
    
    func onSuccess(friends:Array<User>)
    
    func onEmptyFriends()
    
}

class FriendsProvider: NSObject {

    class func getFriends(callback:FriendsCallback) {
        println(FBSDKAccessToken.currentAccessToken().userID)
        let meRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: nil)
        meRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            callback.prepareToRespose()
            if error == nil {
                let dataDict:NSDictionary = result as! NSDictionary
                let friendsArray:Array<NSDictionary> = dataDict.objectForKey("data")! as! Array<NSDictionary>
                var result = Array<User>()
                for dict in friendsArray {
                    var user = User()
                    user.name = dict.objectForKey("name") as? String
                    user.facebookId = dict.objectForKey("id") as? String
                    user.profileImage = String(format: "http://graph.facebook.com/%@/picture?type=normal", user.facebookId!)
                    result.append(user)
                }
                
                if result.count == 0 {
                    callback.onEmptyFriends()
                }else{
                    callback.onSuccess(result)
                }
                println(result)
            } else {
                callback.onConnectionFailToRequest()
            }
        })
    }
    
}
