//
//  MatchResultViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import GoogleMobileAds

class MatchResultViewController: BaseViewController {

    var interstitial: GADInterstitial?
    var game:Game?
    
    @IBOutlet weak var winnerTitleLabel: UILabel!
    @IBOutlet weak var looserLabel: UILabel!
    @IBOutlet weak var disclaimerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-6732487218165467/6363960639")
        var gadRequest = GADRequest()
        gadRequest.testDevices = [ kGADSimulatorID, "f1abdfdf0b24e308ec273def74fd4fd1" ];
        interstitial?.loadRequest(gadRequest)
    }


    func setup() {
        winnerTitleLabel.text = Messages.message("winner.title")
        looserLabel.text = game?.getOponent().name?.uppercaseString
        disclaimerLabel.text = String(format: Messages.message("winner.disclaimer"), arguments: [game!.getOponent().name!])
//            Messages.message("winner.disclaimer")
    }
    
    @IBAction func shareAction(sender: AnyObject) {
        var imageURL = NSURL(string: game!.getOponent().profileImage!)
        var photo = FBSDKSharePhoto(imageURL: imageURL, userGenerated: false)
        var properties = ["og:type": "appparouimpar:friend",
                            "og:title": ("Defeated " + game!.getOponent().name!),
                            "og:description":"One more hard battle, one more Victory. Will you beat me in this great game?",
//                            "og:url":"https://www.facebook.com/poweroftwoapp",
//                            "og:image":photo
        ]
        var shareObject = FBSDKShareOpenGraphObject(properties: properties)
        var shareAction = FBSDKShareOpenGraphAction(type: "appparouimpar:defeat", object: shareObject, key: "friend")
        var shareContent = FBSDKShareOpenGraphContent()
        shareContent.action = shareAction
        shareContent.previewPropertyName = "friend"
        
        var dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = shareContent
        dialog.delegate = self
        if dialog.canShow() {
            dialog.show()
        }else {
            var error:NSError?
            dialog.validateWithError(&error)
            println(error)
        }
    
    }
    
    @IBAction func backToHomeAction(sender: AnyObject) {
        if interstitial!.isReady {
            interstitial!.presentFromRootViewController(self)
        }
        navigationController?.popToViewController(navigationController!.viewControllers[1] as! UIViewController, animated: true)
    }
    
}

extension MatchResultViewController: FBSDKSharingDelegate {
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        println("SUCCESS")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        println("ERROR \(error)")
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        println("CANCEL")
    }
    
}
