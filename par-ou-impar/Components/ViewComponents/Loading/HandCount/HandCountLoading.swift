//
//  HandCountLoading.swift
//  par-ou-impar
//
//  Created by Vitor Machado oliveira on 10/07/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class HandCountLoading: Loading {

    @IBOutlet weak var handImageView: UIImageView!
    var timer:NSTimer?
    var imageIndex:Int = 0
    
    override func customSetup() {
        backgroundColor = ColorProvider.getAppColor()
    }
    
    override func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateImage", userInfo: nil, repeats: true)
    }
    
    func updateImage() {
        imageIndex = (imageIndex + 1 % 6)
        handImageView.image = UIImage(named: "img_mao_normal_\(imageIndex)")
    }
    
    override func stop() {
        if timer != nil {
            timer!.invalidate()
        }
        removeFromSuperview()
    }

}
