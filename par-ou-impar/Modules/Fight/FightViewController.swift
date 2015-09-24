//
//  FightViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import QuartzCore

class FightViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myHandImageView: UIImageView!
    @IBOutlet weak var myOptionValue: UILabel!
    
    @IBOutlet weak var opponentHandImageView: UIImageView!
    @IBOutlet weak var opponentImageView: UIImageView!
    @IBOutlet weak var opponentOptionValue: UILabel!
    
    var introIndex:Int = 0
    var introTimer:NSTimer?
    var introTexts = ["PREPARE", "READY?", "FIGHT!"]
    
    var fightIndex:Int = 0
    var fightTimer:NSTimer?
    
    var game:Game?
    
    var myFightHand:FightHand?
    var friendFightHand:FightHand?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.trackOpenScreen(ANALYTICS_SCREEN_GAME)
        loadInfos()
        setup()
    }
    
    func loadInfos() {
        myFightHand = game?.getMyHand()
        friendFightHand = game?.getOpponentHand()
        
    }

    func setup() {
        setupOptions()
        setGameVisualized()
        myImageView.setImage(url: game!.getMe().profileImage!)
        opponentImageView.setImage(url: game!.getOponent().profileImage!)
        
        introTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("nextIntroStep"), userInfo: nil, repeats: true)
        
        myHandImageView.image = UIImage(named: myFightHand!.imagePrefix! + "0")
        opponentHandImageView.image = UIImage(named: friendFightHand!.imagePrefix! + "0")
        opponentHandImageView.layer.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI)))
    }
    
    func setupOptions(){
        if(game!.amIOwner()){
            myOptionValue.text = Messages.message("option.value.even")
            opponentOptionValue.text = Messages.message("option.value.odd")
        }else{
            myOptionValue.text = Messages.message("option.value.odd")
            opponentOptionValue.text = Messages.message("option.value.even")
        }
        
    }
    
    func setGameVisualized() {
        if(game!.amIOwner()){
            game!["ownerVisualized"] = true;
            game!.saveInBackground()
        }
    }
    
    func nextIntroStep() {
        if(introIndex == 3) {
            introTimer?.invalidate()
            titleLabel.hidden = true
            fightTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("nextFightStep"), userInfo: nil, repeats: true)
            return
        }
        titleLabel.text = introTexts[introIndex]
        introIndex += 1
    }
    
    func nextFightStep() {
        if(fightIndex == 2) {
            myHandImageView.image = UIImage(named: myFightHand!.imagePrefix! + game!.getMyCount().description)
            opponentHandImageView.image = UIImage(named: friendFightHand!.imagePrefix! + game!.getOpponentCount().description)
        }
        if(fightIndex == 3) {
            titleLabel.hidden = false
            titleLabel.text = game?.getWinnerText()
        }
        if(fightIndex == 4) {
            fightTimer?.invalidate()
            if game!.amIWinner() {
                
                let viewController = MatchResultViewController()
                viewController.game = game
                navigationController?.pushViewController(viewController, animated: true)
            } else {
                let viewController = LooseViewController()
                viewController.game = game
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
        fightIndex += 1
    }
    
}
