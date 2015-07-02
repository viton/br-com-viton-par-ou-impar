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

class HomeViewController: BaseViewController, GamesCallback, PlaceholderActionDelegate {

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
        tableManager = BaseTableViewManager(tableView: tableView)
        
    }
    
    @IBAction func newGameAction(sender: AnyObject) {
        navigationController?.pushViewController(NewGameViewController(), animated: true)
    }
    
    
    
    //MARK: GamesCallback
    func onSuccess(games:Array<Game>) {
        tableManager?.updateWithData(games)
    }
    
    func onEmptyGamesList() {
        noResultsPlaceholder = view.addPlaceholder("New here?", content: "We found no games for you. Click here and have fun", buttonTitle: "My first Game", image: nil)
        noResultsPlaceholder?.delegate = self
    }
    
    override func prepareToRespose() {
        super.prepareToRespose()
        view.stopLoading()
        view.removePlaceholder(&noResultsPlaceholder)
    }
    
    override func didClickPlaceholderAction(placeholder:Placeholder) {
        if placeholder == noResultsPlaceholder {
            newGameAction(placeholder)
        }
    }
}
