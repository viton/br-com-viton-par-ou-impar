//
//  FightHandProvider.swift
//  par-ou-impar
//
//  Created by Vitor Machado oliveira on 07/07/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class FightHandProvider: NSObject {
   
    class func getHands() -> [FightHand] {
        var array = Array<FightHand>()
        array.append(FightHand(name: "Normal", imagePrefix: "img_mao_normal_"))
        return []
    }
    
}
