//
//  FightHand.swift
//  par-ou-impar
//
//  Created by Vitor Machado oliveira on 07/07/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class FightHand: NSObject {
   
    var imagePrefix:String?
    var name:String?
    
    init(name:String, imagePrefix:String) {
        self.imagePrefix = imagePrefix
        self.name = name
        super.init()
    }
    
}
