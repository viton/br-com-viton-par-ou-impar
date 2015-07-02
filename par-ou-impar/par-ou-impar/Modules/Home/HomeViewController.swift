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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        GameProvider.getGames(FBSDKAccessToken.currentAccessToken().userID)
    }
    
    func setup() {
        println(FBSDKAccessToken.currentAccessToken().userID)
        navigationController?.navigationBarHidden = true
        tableManager = BaseTableViewManager(tableView: tableView)
        
    }
    
    @IBAction func newGameAction(sender: AnyObject) {
        navigationController?.pushViewController(NewGameViewController(), animated: true)
    }
    
    
}
