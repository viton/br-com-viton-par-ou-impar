//
//  HomeViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Parse

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableManager:BaseTableViewManager?
    var noResultsPlaceholder:Placeholder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        requestGames()
    }
    
    func requestGames() {
        view.startLoading()
        GameProvider.getGames(FBSDKAccessToken.currentAccessToken().userID, callback:self)
    }
    
    func setup() {
        println(FBSDKAccessToken.currentAccessToken().userID)
        navigationController?.navigationBarHidden = true
        tableManager = BaseTableViewManager(tableView: tableView, delegate:self)
        
    }
    
    @IBAction func newGameAction(sender: AnyObject) {
        navigationController?.pushViewController(NewGameViewController(), animated: true)
    }
    
    //MARK: PlaceholderActionDelegate
    override func didClickPlaceholderAction(placeholder:Placeholder) {
        if placeholder == noResultsPlaceholder {
            newGameAction(placeholder)
        }
    }
    
    //MARK: BaseProviderCallback
    override func prepareToRespose() {
        super.prepareToRespose()
        view.stopLoading()
        view.removePlaceholder(&noResultsPlaceholder)
    }

}

extension HomeViewController: BaseTableViewManagerDelegate {
    
    func didSelectGameToReply(game:Game) {
        let replyGameViewController = ReplyGameViewController()
        replyGameViewController.game = game
        navigationController?.pushViewController(replyGameViewController, animated: true)
    }
    
    func didSelectFinishGame(game:Game) {
        let fightViewController = FightViewController()
        fightViewController.game = game
        navigationController?.pushViewController(fightViewController, animated: true)
    }
    
}

//MARK: GamesCallback
extension HomeViewController: GamesCallback {
    
    func onSuccess(games:Array<Game>) {
        tableManager?.updateWithData(games)
    }
    
    func onEmptyGamesList() {
        noResultsPlaceholder = view.addPlaceholder("New here?", content: "We found no games for you. Click here and have fun", buttonTitle: "My first Game", image: nil)
        noResultsPlaceholder?.delegate = self
    }
    
}