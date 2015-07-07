//
//  SimpleLoading.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/7/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class SimpleLoading: Loading {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func customSetup() {
        backgroundColor = ColorProvider.getAppColor()
    }
    
    override func start() {
        activityIndicator.startAnimating()
    }
    
    override func stop() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }

}
