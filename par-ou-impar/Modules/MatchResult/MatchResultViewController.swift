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
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButtonContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.trackOpenScreen(ANALYTICS_SCREEN_RESULT_SUCCESS)
        setup()
        interstitial = GADInterstitial(adUnitID: MATCH_RESULT_GOOGLE_ADS_INTERSTITIAL_UNIT_ID)
        let gadRequest = GADRequest()
        gadRequest.testDevices = GOOGLE_REQUEST_TEST_DEVICES
        interstitial?.loadRequest(gadRequest)
    }


    func setup() {
        shareButton.setTitle(Messages.message("winner.share.button"))
        winnerTitleLabel.text = Messages.message("winner.title")
        looserLabel.text = game?.getOponent().name?.uppercaseString
        disclaimerLabel.text = String(format: Messages.message("winner.disclaimer"), arguments: [game!.getOponent().name!])
        setupLikeButton()
    }
    
    func setupLikeButton(){
        let button = FBSDKLikeControl()
        button.likeControlStyle = FBSDKLikeControlStyle.Standard
        button.likeControlHorizontalAlignment = FBSDKLikeControlHorizontalAlignment.Left
        button.objectID = "https://www.facebook.com/parouimpar99"
        self.likeButtonContainer.addSubview(button)
    }
    
    @IBAction func shareAction(sender: AnyObject) {
//        let imageURL = NSURL(string: game!.getOponent().profileImage!)
//        let photo = FBSDKSharePhoto(imageURL: imageURL, userGenerated: false)
        let properties = ["og:type": "appparouimpar:friend",
                            "og:title": (Messages.message("winner.share.title") + game!.getOponent().name!),
                            "og:description":Messages.message("winner.share.text"),
                            "og:url":"https://www.facebook.com/parouimpar99",
//                            "og:image":photo
        ]
        let shareObject = FBSDKShareOpenGraphObject(properties: properties)
        let shareAction = FBSDKShareOpenGraphAction(type: "appparouimpar:defeat", object: shareObject, key: "friend")
        let shareContent = FBSDKShareOpenGraphContent()
        shareContent.action = shareAction
        shareContent.previewPropertyName = "friend"
        
        let dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = shareContent
        dialog.delegate = self
        if dialog.canShow() {
            dialog.show()
        }else {
            var error:NSError?
            do {
                try dialog.validate()
            } catch let error1 as NSError {
                error = error1
            }
            print(error)
        }
    
    }
    
    @IBAction func backToHomeAction(sender: AnyObject) {
        if interstitial!.isReady {
            interstitial!.presentFromRootViewController(self)
        }
        navigationController?.popToViewController(navigationController!.viewControllers[1] , animated: true)
    }
    
}

extension MatchResultViewController: FBSDKSharingDelegate {
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("SUCCESS")
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("ERROR \(error)")
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("CANCEL")
    }
    
}
