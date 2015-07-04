//
//  Loading.swift
//  SwiftStudies
//
//  Created by Taqtile on 6/30/15.
//  Copyright (c) 2015 viton. All rights reserved.
//

import UIKit

class Loading: BaseComponentsView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func customSetup() {
        backgroundColor = UIColor.lightGrayColor()
    }
    
    func start() {
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }
    
}
