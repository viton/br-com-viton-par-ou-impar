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
    var tableManager:GameTableViewManager?
    var noResultsPlaceholder:Placeholder?
    
    @IBOutlet weak var chooseColorWIfthConstraint: NSLayoutConstraint!
    @IBOutlet weak var chooseColorView: ChooseColorView!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAds()
    }
    
    func setupAds(){
        gadBannerView.adUnitID = GOOGLE_ADS_BANNER_UNIT_ID
        gadBannerView.rootViewController = self
        let gadRequest = GADRequest()
        gadRequest.testDevices = GOOGLE_REQUEST_TEST_DEVICES
        gadBannerView.loadRequest(gadRequest)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        requestGames()
        navigationController?.navigationBarHidden = true
    }
    
    func requestGames() {
        view.startLoadingRandom(Messages.message("home.loading.games.message"))
        GameProvider.getGames(FBSDKAccessToken.currentAccessToken().userID, callback:self)
    }
    
    func setup() {
        newGameButton.setTitle(Messages.message("home.new.game.button.title"))
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
        tableManager?.stopRefreshControl()
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
    }

    func onPullToRefresh() {
        GameProvider.getGames(FBSDKAccessToken.currentAccessToken().userID, callback:self)
    }
    
}

//MARK: GamesCallback
extension HomeViewController: GamesCallback {
    
    func onSuccess(games:Array<Game>) {
        tableManager?.updateWithData(games)
    }
    
    func onEmptyGamesList() {
        noResultsPlaceholder = view.addPlaceholder(Messages.message("home.no.games.placeholder.title"), content: Messages.message("home.no.games.placeholder.descriptions"), buttonTitle: Messages.message("home.no.games.placeholder.button.title"), image: nil)
        noResultsPlaceholder?.delegate = self
    }
    
}