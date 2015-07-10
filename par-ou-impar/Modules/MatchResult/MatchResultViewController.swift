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
//        var content = FBSDKShareOpenGraphContent()
//        content.peopleIDs = [game!.getOponent().facebookId!]
//        content.action = FBSDKShareOpenGraphAction()
//        content.previewPropertyName = "og.like"
//        var dialog = FBSDKShareDialog()
//        dialog.fromViewController = self
//        dialog.shareContent = content
//        dialog.mode = FBSDKShareDialogMode.ShareSheet
//        if dialog.canShow() {
//            dialog.show()
//        }else {
//            var error:NSError?
//            dialog.validateWithError(&error)
//            println(error)
//        }
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Vea Software! :D")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        }
    
    }
    
    @IBAction func backToHomeAction(sender: AnyObject) {
        
    }
    
}
