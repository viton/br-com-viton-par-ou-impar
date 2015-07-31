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
        array.append(FightHand(name: "Normal", imagePrefix: "img_mao_normal_", handId: "normal"))
        array.append(FightHand(name: "Rocker", imagePrefix: "img_mao_rocker_", handId: "rocker"))
        array.append(FightHand(name: "Rednails", imagePrefix: "img_mao_rednails_", handId: "rednails"))
        array.append(FightHand(name: "Normal", imagePrefix: "img_mao_normal_", handId: "normal"))
        array.append(FightHand(name: "Rocker", imagePrefix: "img_mao_rocker_", handId: "rocker"))
        array.append(FightHand(name: "Rednails", imagePrefix: "img_mao_rednails_", handId: "rednails"))
        return array
    }
    
    class func find(id: String) -> FightHand {
        for hand in FightHandProvider.getHands() {
            if(hand.handId == id) {
                return hand
            }
        }
        return FightHand(name: "Normal", imagePrefix: "img_mao_normal_", handId: "normal")
    }
    
}
