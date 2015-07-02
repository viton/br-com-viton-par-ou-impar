//
//  LoginProvider.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

protocol UserProviderCallback:BaseProviderCallback {
    
    func onSuccessRetrieveUser(user:User)
    
}

class LoginProvider: NSObject {
   
    static let user = User()
    
    class func loadUser(callback:UserProviderCallback) {
        let meRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        meRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            callback.prepareToRespose()
            if error == nil {
                let dictResult = result as! NSDictionary
                LoginProvider.user.facebookId = FBSDKAccessToken.currentAccessToken().userID
                LoginProvider.user.name = dictResult["name"]! as? String
                LoginProvider.user.profileImage = String(format: "http://graph.facebook.com/%@/picture?type=normal", FBSDKAccessToken.currentAccessToken().userID)
                callback.onSuccessRetrieveUser(LoginProvider.user)
            } else {
                callback.onConnectionFailToRequest()
            }
        })
    }
    
    class func register(user:User) {
        let userObject = PFObject(className: "User")
        userObject["facebookId"] = user.facebookId
        userObject["name"] = user.name
        userObject["profileImageUrl"] = user.profileImage

        var query = PFQuery(className:"User")
        query.whereKey("facebookId", equalTo: user.facebookId!)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    if(objects.count == 0){
                        userObject.saveInBackground()
                    }
                }
            }
        }
    }
    
}
