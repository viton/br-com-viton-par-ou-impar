//
//  ReplyGameViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class ReplyGameViewController: UIViewController {

    var game:Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func requestReplyGame() {
        game?.enemyCount = 2
        game?.enemyHand = "normal"
        game?.finish = 1
        game?.winner = game?.decideWinner()
        GameProvider.replyGame(game!)
    }
    
    
    
}