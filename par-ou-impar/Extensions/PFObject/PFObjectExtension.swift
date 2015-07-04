//
//  PFObjectExtension.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import Foundation
import Parse

extension PFObject {
    
    typealias POISuccessBlock = (AnyObject?) -> Void
    typealias POIErrorBlock = (String) -> Void
    typealias POINoConnectionBlock = () -> Void
    
    func saveInBackground(successBlock:POISuccessBlock, errorBlock:POIErrorBlock, noConnection:POINoConnectionBlock) {
        saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            println(success)
            if(success) {
                successBlock(nil)
            }
            println(error)
        })
    }
    
}