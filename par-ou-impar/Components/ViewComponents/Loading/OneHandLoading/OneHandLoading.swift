//
//  OneHandLoading.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/7/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class OneHandLoading: Loading {

    @IBOutlet weak var handImageView: UIImageView!
    var timer:NSTimer?
    var imageIndex:Int = 1
    
    override func customSetup() {
        backgroundColor = ColorProvider.getAppColor()
    }
    
    override func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateImage", userInfo: nil, repeats: true)
    }
    
    func updateImage() {
        imageIndex = (imageIndex % 3) + 1
        handImageView.image = UIImage(named: "img_hand_\(imageIndex)")
    }
    
    override func stop() {
        if timer != nil {
            timer!.invalidate()
        }
        removeFromSuperview()
    }
    
}
