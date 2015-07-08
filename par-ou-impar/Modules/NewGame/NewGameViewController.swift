//
//  NewGameViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit


class NewGameViewController: BaseViewController {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var chooseHandView: ChooseHandView!
    @IBOutlet weak var betTextField: UITextField!
    var chooseFriendViewController:ChooseFriendViewController?
    var friend:User?
    var me:User?
    var count:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }

    func setup() {
        title = "Novo"
        navigationController?.navigationBarHidden = false
        chooseHandView.chooseHandViewDelegate = self
        me = LoginProvider.user
    }

    @IBAction func chooseFriendAction(sender: AnyObject) {
        chooseFriendViewController = ChooseFriendViewController()
        chooseFriendViewController?.delegate = self
        presentViewController(chooseFriendViewController!, animated: true, completion: {})
    }
    
    @IBAction func createGameAction(sender: AnyObject) {
        let game = Game()
        game.enemy = friend?.facebookId
        game.owner = me?.facebookId
        game.ownerHand = "normal"
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
        navigationController?.popViewControllerAnimated(true)
    }
    
}

extension NewGameViewController: ChooseHandViewDelegate {
    
    func didSelectHandCount(count: Int) {
        self.count = count
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
