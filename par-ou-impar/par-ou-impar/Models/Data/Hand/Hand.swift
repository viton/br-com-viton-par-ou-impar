//
//  Hand.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse

class Hand: PFObject, PFSubclassing {
   
    var count:Int?
    var imagePrefixName:String?
    
    class func parseClassName() -> String {
        return "Hand"
    }
    
}
