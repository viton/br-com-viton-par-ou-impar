//
//  LooseViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/27/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LooseViewController: BaseViewController {

    var interstitial: GADInterstitial?
    var game:Game?
    
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupAds()
    }
    
    func setup() {
        titleLabel.text = Messages.message("looser.title");
        backButton.setTitle(Messages.message("looser.back.button"))
        opponentNameLabel.text = game?.getOponent().name
        disclaimerLabel.text = String(format: Messages.message("looser.disclaimer"), arguments: [game!.getOponent().name!])
    }
    
    func setupAds() {
        interstitial = GADInterstitial(adUnitID: GOOGLE_ADS_INTERSTITIAL_UNIT_ID)
        var gadRequest = GADRequest()
        gadRequest.testDevices = GOOGLE_REQUEST_TEST_DEVICES
        interstitial?.loadRequest(gadRequest)
    }

    @IBAction func backToHomeAction(sender: AnyObject) {
        if interstitial!.isReady {
            interstitial!.presentFromRootViewController(self)
        }
        navigationController?.popToViewController(navigationController!.viewControllers[1] as! UIViewController, animated: true)
    }

    
}
