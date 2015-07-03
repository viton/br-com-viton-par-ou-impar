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
        facebookLoginButton.readPermissions = ["public_profile", "user_friends"]
        println(facebookLoginButton.readPermissions)
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
    
    func onSuccessRetrieveUser(user: User) {
        navigationController?.pushViewController(HomeViewController(), animated: false)
    }
    
}