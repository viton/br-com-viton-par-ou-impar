//
//  NewGameViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit


class NewGameViewController: BaseViewController {

    @IBOutlet weak var betTextField: UITextField!
    var chooseFriendViewController:ChooseFriendViewController?
    var friend:User?
    var me:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Novo"
        navigationController?.navigationBarHidden = false
        requestUser()
    }
    
    func requestUser() {
        view.startLoading()
        LoginProvider.loadUser(self)
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
        game.ownerCount = 1
        game.betText = betTextField.text
        GameProvider.createGame(game, owner:me!, enemy:me!)
    }

    //MARK: BaseProviderCallback
    override func prepareToRespose() {
        view.stopLoading()
    }
    
}

//MARK: UserProviderCallback
extension NewGameViewController: UserProviderCallback {
    
    func onSuccessRetrieveUser(user: User) {
        me = user
    }
    
}

//MARK: ChooseFriendsDelegate
extension NewGameViewController: ChooseFriendsDelegate {
    
    func didSelectFriend(friend: User) {
        chooseFriendViewController?.dismissViewControllerAnimated(true, completion: {
            self.friend = friend
        })
    }
}
