//
//  LoginProvider.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse

class LoginProvider: NSObject {
   
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
