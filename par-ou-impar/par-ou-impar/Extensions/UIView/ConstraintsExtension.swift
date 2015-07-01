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
        var topConstraint = constraint(contentView, attribute:NSLayoutAttribute.Top);
        var bottomConstraint = constraint(contentView, attribute:NSLayoutAttribute.Bottom);
        var leadingConstraint = constraint(contentView, attribute:NSLayoutAttribute.Leading);
        var trailingConstraint = constraint(contentView, attribute:NSLayoutAttribute.Trailing);
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]);
    }
    
    private func constraint(contentView:UIView, attribute:NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item:self, attribute:attribute, relatedBy:NSLayoutRelation.Equal, toItem:contentView, attribute:attribute , multiplier:1.0, constant:0);
        return constraint
    }
    
}