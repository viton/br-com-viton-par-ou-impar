//
//  HomeViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(FBSDKAccessToken.currentAccessToken().userID)
        navigationController?.navigationBarHidden = true
    }
    
    @IBAction func newGameAction(sender: AnyObject) {
        navigationController?.pushViewController(NewGameViewController(), animated: true)
    }
    
}
