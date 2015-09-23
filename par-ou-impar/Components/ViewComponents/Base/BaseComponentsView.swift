//
//  BaseComponentsView.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/25/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit

@IBDesignable class BaseComponentsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentViewAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContentViewAndConstraints()
    }
    
    
    private func setupContentViewAndConstraints() {
        let contentView:AnyObject? = NSBundle(forClass: self.dynamicType).loadNibNamed(NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!, owner: self, options: nil).first
        addSubview(contentView! as! UIView)
        addAllConstraints(contentView! as! UIView);
        customSetup()
    }
    
    func customSetup() {}
    
}
