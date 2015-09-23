//
//  SplashScreenViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 9/21/15.
//  Copyright © 2015 Viton. All rights reserved.
//

import UIKit

class SplashScreenViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var timer : NSTimer?
    var hands : [FightHand]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
    }

    func setupTimer() {
        hands = FightHandProvider.getHands()
        hands?.appendContentsOf(hands!)
        hands?.appendContentsOf(hands!)
        hands?.appendContentsOf(hands!)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimer", userInfo: nil, repeats: true);
    }
    
    func updateTimer() {
        if hands?.count != 0 {
            let hand = hands?.first
            let suffix = random()%6
            imageView.image = UIImage(named: (hand?.imagePrefix)! + suffix.description)
            hands?.removeFirst()
        } else {
            timer?.invalidate()
            let window = UIApplication.sharedApplication().delegate?.window
            window!!.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
    }

}
