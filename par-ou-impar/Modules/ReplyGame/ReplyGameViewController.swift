//
//  ReplyGameViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse

class ReplyGameViewController: BaseViewController {

    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var betTextLabel: UILabel!
    @IBOutlet weak var chooseHandView: ChooseHandView!

    var count:Int?
    var hand:FightHand?
    
    var game:Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        friendImageView.setImage(url: game!.getOponent().profileImage!)
        friendNameLabel.text = game?.getOponent().name
        betTextLabel.text = game?.betText
        chooseHandView.chooseHandViewDelegate = self
    }
    
    func requestReplyGame() {
        view.startLoading()
        game?.enemyCount = count
        game?.enemyHand = hand?.handId
        game?.finish = 1
        game?.winner = game?.decideWinner()
        GameProvider.replyGame(game!, callback: self)
    }
    
    @IBAction func replyAction(sender: AnyObject) {
        requestReplyGame()
    }
    
}

extension ReplyGameViewController: ReplyGameCallback {
    
    override func prepareToRespose() {
        super.prepareToRespose()
        view.stopLoading()
    }
    
    func onSuccessReplyGame(game: Game) {
        var viewController = FightViewController()
        viewController.game = game
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ReplyGameViewController: ChooseHandViewDelegate {
    
    func didSelectHandCount(count: Int) {
        self.count = count
    }
    
    func didSelectHand(hand: FightHand) {
        self.hand = hand
    }
    
}