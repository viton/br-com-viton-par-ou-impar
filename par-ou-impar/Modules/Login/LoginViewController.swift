//
//  LoginViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: BaseViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(FBSDKAccessToken.currentAccessToken() != nil) {
            requestUser()
        }
    }
    
    func setup () {
        navigationController?.navigationBarHidden = true
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        facebookLoginButton.delegate = self
        facebookLoginButton.readPermissions = ["user_friends"]
        facebookLoginButton.publishPermissions = ["publish_actions"]
    }

    //MARK: FBSDKLoginButtonDelegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if(error != nil){
            println(error)
        }else if(result.isCancelled) {
            println("CANCELED")
        }else {
            requestUser()
        }
    }
    
    func requestUser() {
        view.startLoading()
        LoginProvider.loadUser(self)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("LOGOUT")
    }
    
    override func prepareToRespose() {
        super.prepareToRespose()
        view.stopLoading()
        
    }
    
    override func didClickPlaceholderAction(placeholder: Placeholder) {
        super.didClickPlaceholderAction(placeholder)
        if placeholder == noConnectionPlaceholder {
            requestUser()
        }
    }
    
}

//MARK: UserProviderCallback
extension LoginViewController: UserProviderCallback {
    
    func onSuccessRetrieveUser(user: User, moreInfo:NSDictionary!) {
        let installation = PFInstallation.currentInstallation()
        installation["userFacebookId"] = user.facebookId
        appendInfos(moreInfo, toInstallation: installation)
        installation.saveInBackground()
        navigationController?.pushViewController(HomeViewController(), animated: false)
    }
    
    func appendInfos(infos:NSDictionary, toInstallation installation:PFInstallation) {
        if installation.channels == nil {
            installation.channels = []
        }
        var desirableInfos = ["gender"]
        for info in desirableInfos {
            if let userInfo = infos[info] as? String {
                installation.channels?.append(userInfo)
            }
        }
    }
    
}