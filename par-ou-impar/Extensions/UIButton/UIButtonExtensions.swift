//
//  UIButtonExtensions.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/30/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setTitle(title:String?){
        setTitle(title?.uppercaseString, forState: UIControlState.Normal)
    }
    
}