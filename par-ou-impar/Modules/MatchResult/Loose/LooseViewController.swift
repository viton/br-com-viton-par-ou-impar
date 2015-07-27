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
    @IBOutlet weak var disclaimerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupAds()
    }
    
    func setup() {
        opponentNameLabel.text = game?.getOponent().name
        disclaimerLabel.text = String(format: Messages.message("looser.disclaimer"), arguments: [game!.getOponent().name!])
    }
    
    func setupAds() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-6732487218165467/6363960639")
        var gadRequest = GADRequest()
        gadRequest.testDevices = [ kGADSimulatorID, "f1abdfdf0b24e308ec273def74fd4fd1" ];
        interstitial?.loadRequest(gadRequest)
    }

    @IBAction func backToHomeAction(sender: AnyObject) {
        if interstitial!.isReady {
            interstitial!.presentFromRootViewController(self)
        }
        navigationController?.popToViewController(navigationController!.viewControllers[1] as! UIViewController, animated: true)
    }

    
}
