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
            navigationController?.pushViewController(HomeViewController(), animated: false)
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
            navigationController?.pushViewController(HomeViewController(), animated: false)
//            println(FBSDKAccessToken.currentAccessToken().userID)
//            let pictureRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
//            pictureRequest.startWithCompletionHandler({
//                (connection, result, error: NSError!) -> Void in
//                if error == nil {
//                    println("\(result)")
//                } else {
//                    println("\(error)")
//                }
//            })
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("LOGOUT")
    }
    
}
