//
//  NewGameViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NewGameViewController: BaseViewController {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var chooseHandView: ChooseHandView!
    @IBOutlet weak var betTextField: UITextField!
    @IBOutlet weak var createGameButton: UIButton!
    @IBOutlet weak var chooseFriendButton: UIButton!
    
    var interstitial: GADInterstitial?
    
    var chooseFriendViewController:ChooseFriendViewController?
    var friend:User?
    var me:User?
    var count:Int?
    var hand:FightHand?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }

    func setup() {
        createGameButton.setTitle(Messages.message("game.create.button"))
        chooseFriendButton.setTitle(Messages.message("game.choose.opponent.button"))
        chooseHandView.optionValueLabel.text = Messages.message("option.value.even")
        navigationController?.navigationBarHidden = false
        chooseHandView.chooseHandViewDelegate = self
        me = LoginProvider.user
        setupAds()
    }
    
    func setupAds() {
        interstitial = GADInterstitial(adUnitID: NEW_GAME_GOOGLE_ADS_INTERSTITIAL_UNIT_ID)
        var gadRequest = GADRequest()
        gadRequest.testDevices = GOOGLE_REQUEST_TEST_DEVICES
        interstitial?.loadRequest(gadRequest)
    }
    
    func validate () -> (Bool, String) {
        if friend == nil {
            return (false, Messages.message("game.validation.opponent"))
        }
        if hand == nil {
            return (false, Messages.message("game.validation.hand"))
        }
        if count == nil {
            return (false, Messages.message("game.validation.count"))
        }
        return (true, "")
    }

    @IBAction func chooseFriendAction(sender: AnyObject) {
        chooseFriendViewController = ChooseFriendViewController()
        chooseFriendViewController?.delegate = self
        presentViewController(chooseFriendViewController!, animated: true, completion: {})
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func createGameAction(sender: AnyObject) {
        if(!validate().0) {
            alert(validate().1)
            return
        }
        let game = Game()
        game.enemy = friend?.facebookId
        game.owner = me?.facebookId
        game.ownerHand = hand?.handId
        game.ownerCount = count
        game.betText = betTextField.text
        GameProvider.createGame(game, owner:me!, enemy:friend!, callback: self)
        view.startLoading()
    }

    //MARK: BaseProviderCallback
    override func prepareToRespose() {
        view.stopLoading()
    }
    
}

extension NewGameViewController: CreateGameCallback {
    
    func onSuccessCreateGame() {
        if interstitial!.isReady {
            interstitial!.presentFromRootViewController(self)
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
}

extension NewGameViewController: ChooseHandViewDelegate {
    
    func didSelectHandCount(count: Int) {
        self.count = count
    }
    
    func didSelectHand(hand: FightHand) {
        self.hand = hand
    }
    
}

//MARK: ChooseFriendsDelegate
extension NewGameViewController: ChooseFriendsDelegate {
    
    func didSelectFriend(friend: User) {
        chooseFriendViewController?.dismissViewControllerAnimated(true, completion: {
            self.friend = friend
            self.friendNameLabel.text = friend.name
            self.friendImageView.setImage(url: friend.profileImage!)
        })
    }
}
