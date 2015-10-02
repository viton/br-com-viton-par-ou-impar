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
        array.append(FightHand(name: "Negra", imagePrefix: "img_mao_normal_negra_", handId: "normal_brown"))
        array.append(FightHand(name: "Watch", imagePrefix: "img_mao_watch_", handId: "watch"))
        array.append(FightHand(name: "Rocker", imagePrefix: "img_mao_rocker_", handId: "rocker"))
        array.append(FightHand(name: "Branca", imagePrefix: "img_mao_normal_", handId: "normal_white"))
        array.append(FightHand(name: "Bluenails", imagePrefix: "img_mao_bluenails_", handId: "bluenails"))
        array.append(FightHand(name: "Reggae", imagePrefix: "img_mao_reggae_", handId: "reggae"))
        array.append(FightHand(name: "Rednails", imagePrefix: "img_mao_rednails_", handId: "rednails"))
        array.append(FightHand(name: "BlackSuit", imagePrefix: "img_mao_blacksuit_", handId: "blacksuit"))
        array.append(FightHand(name: "WhiteSuit", imagePrefix: "img_mao_whitesuit_", handId: "whitesuit"))
        return array
    }
    
    class func find(id: String) -> FightHand {
        for hand in FightHandProvider.getHands() {
            if(hand.handId == id) {
                return hand
            }
        }
        return FightHand(name: "Branca", imagePrefix: "img_mao_normal_", handId: "normal_white")
    }
    
}
