//
//  FriendsProvider.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

protocol FriendsCallback: BaseProviderCallback {
    
    func onSuccess(friends:Array<User>)
    
    func onEmptyFriends()
    
}

class FriendsProvider: NSObject {

    class func getFriends(callback:FriendsCallback) {
        if(self.hasFriendsPermission()) {
            FriendsProvider.getFriendsAfterFacebookLogin(callback)
        }else {
            let loginManager = FBSDKLoginManager()
            loginManager.logInWithReadPermissions(["user_friends"], handler: { (result, error) in
                print("Result \(result) error \(error)")
                if error == nil {
                    FriendsProvider.getFriendsAfterFacebookLogin(callback)
                }else{
                    callback.prepareToRespose()
                    callback.onEmptyFriends()
                }
            } )
        }
    }
    
    class func hasFriendsPermission() -> Bool {
        return FBSDKAccessToken.currentAccessToken().hasGranted("user_friends")
    }
    
    class func getFriendsAfterFacebookLogin(callback:FriendsCallback) {
        let meRequest = FBSDKGraphRequest(graphPath: "me/friends?limit=2000", parameters: nil)
        meRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            callback.prepareToRespose()
            if error == nil {
                let dataDict:NSDictionary = result as! NSDictionary
                let friendsArray:Array<NSDictionary> = dataDict.objectForKey("data")! as! Array<NSDictionary>
                var arrayResult = Array<User>()
                for dict in friendsArray {
                    let user = User()
                    user.name = dict.objectForKey("name") as? String
                    user.facebookId = dict.objectForKey("id") as? String
                    user.profileImage = String(format: "http://graph.facebook.com/%@/picture?type=normal", user.facebookId!)
                    arrayResult.append(user)
                }
                
                if arrayResult.count == 0 {
                    callback.onEmptyFriends()
                }else{
                    callback.onSuccess(arrayResult)
                }
                print(arrayResult)
            } else {
                callback.onConnectionFailToRequest()
            }
        })
    }
    
}
