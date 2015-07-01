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
   
    class func login(user:User) {
        let userObject = PFObject(className: "User")
        userObject["facebookId"] = user.facebookId
        userObject["name"] = user.name
        userObject["profileImageUrl"] = user.profileImage
//        userObject.objectId = user.facebookId
        userObject.saveInBackground({ (result:AnyObject?) -> Void in
            
        }, errorBlock:{ (result:String) -> Void in
            
        }, noConnection:{
                
        })
    }
    
}
