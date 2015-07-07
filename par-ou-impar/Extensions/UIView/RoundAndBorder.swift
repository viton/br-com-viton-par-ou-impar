//
//  RoundAndBorder.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/7/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

extension UIView {
    
    func setupBorder(width:CGFloat, color:UIColor) {
        layer.borderColor = color.CGColor
        layer.borderWidth = width
    }
    
    func circle() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
    
}