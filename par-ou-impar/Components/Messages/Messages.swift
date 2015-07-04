//
//  Messages.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/26/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit

class Messages: NSObject {
    
    internal static func message(key:String) -> String {
        let bundle = NSBundle.mainBundle()
        let string = NSLocalizedString(key, tableName: "Messages", bundle: bundle, value: key, comment: "")
        return string
    }
   
}
