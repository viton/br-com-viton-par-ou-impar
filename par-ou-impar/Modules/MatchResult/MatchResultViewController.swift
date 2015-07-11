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
import Social

class MatchResultViewController: BaseViewController {

    var game:Game?
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func rematchAction(sender: AnyObject) {
        
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
        var shareAction = FBSDKShareOpenGraphAction(type: "appparouimpar:defeat", object: shareObject, key: "object")
        var shareContent = FBSDKShareOpenGraphContent()
        shareContent.action = shareAction
        shareContent.previewPropertyName = "object"
        
//        shareContent.peopleIDs = [game!.getOponent().facebookId!]
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
