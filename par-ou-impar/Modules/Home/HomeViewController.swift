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
import GoogleMobileAds

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var gadBannerView: GADBannerView!

    @IBOutlet weak var tableView: UITableView!
    var tableManager:BaseTableViewManager?
    var noResultsPlaceholder:Placeholder?
    
    @IBOutlet weak var chooseColorWIfthConstraint: NSLayoutConstraint!
    @IBOutlet weak var chooseColorView: ChooseColorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAds()
    }
    
    func setupAds(){
        gadBannerView.adUnitID = "ca-app-pub-6732487218165467/7980294632"
        gadBannerView.rootViewController = self
        var gadRequest = GADRequest()
        gadRequest.testDevices = [ kGADSimulatorID ];
        gadBannerView.loadRequest(gadRequest)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        requestGames()
        navigationController?.navigationBarHidden = true
    }
    
    func requestGames() {
        view.startLoadingRandom("Loading Games")
        GameProvider.getGames(FBSDKAccessToken.currentAccessToken().userID, callback:self)
    }
    
    func setup() {
        tableManager = GameTableViewManager(tableView: tableView, delegate:self)
        tableManager?.delegate = self
        chooseColorView.widthConstraint = chooseColorWIfthConstraint
        chooseColorView.callback = self
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

extension HomeViewController: GameTableViewManagerDelegate {
    
    func didSelectGameToReply(game:Game) {
        let replyGameViewController = ReplyGameViewController()
        replyGameViewController.game = game
        navigationController?.pushViewController(replyGameViewController, animated: true)
    }
    
    func didSelectFinishGame(game:Game) {
        let fightViewController = FightViewController()
        fightViewController.game = game
        navigationController?.pushViewController(fightViewController, animated: true)

//        let fightViewController = MatchResultViewController()
//        fightViewController.game = game
//        navigationController?.pushViewController(fightViewController, animated: true)
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