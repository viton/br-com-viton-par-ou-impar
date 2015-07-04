//
//  User.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse

class User: PFObject, PFSubclassing {
    
    @NSManaged var name:String?
    @NSManaged var facebookId:String?
    @NSManaged var profileImage:String?
    
    class func parseClassName() -> String {
        return "User"
    }
    
    
    
}
