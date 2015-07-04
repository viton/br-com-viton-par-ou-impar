//
//  AppDelegate.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

import Bolts
import Parse
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var initialViewController: UIViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        User.registerSubclass()
        Game.registerSubclass()
        
        Parse.setApplicationId("E5kplP1f07JlCIXwXW8iaPyzkUon44N2eyDKSB0s",
            clientKey: "SpHpdIlVhkA7GQzONNuRB55QZjTRbqdWIZaFAPc8")
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds);
        initialViewController = UINavigationController(rootViewController: LoginViewController())
        window!.rootViewController = initialViewController
        window!.makeKeyAndVisible();
        window!.backgroundColor = UIColor.whiteColor();
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions);
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

}

