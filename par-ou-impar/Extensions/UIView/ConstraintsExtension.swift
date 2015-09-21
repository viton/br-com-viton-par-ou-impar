//
//  UIView+Constraints.swift
//  SwiftStudies
//
//  Created by Taqtile on 6/29/15.
//  Copyright (c) 2015 viton. All rights reserved.
//

import UIKit

extension UIView {
    
    func addAllConstraints(contentView:UIView){
        let topConstraint = constraint(contentView, attribute:NSLayoutAttribute.Top);
        let bottomConstraint = constraint(contentView, attribute:NSLayoutAttribute.Bottom);
        let leadingConstraint = constraint(contentView, attribute:NSLayoutAttribute.Leading);
        let trailingConstraint = constraint(contentView, attribute:NSLayoutAttribute.Trailing);
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]);
    }
    
    private func constraint(contentView:UIView, attribute:NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item:self, attribute:attribute, relatedBy:NSLayoutRelation.Equal, toItem:contentView, attribute:attribute , multiplier:1.0, constant:0);
        return constraint
    }
    
}