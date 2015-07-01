//
//  Header.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/25/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit


class Header: BaseComponentsView {

    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBInspectable var titleText: String = "Header" {
        didSet {
            setTitle(titleText)
        }
    }
    
    override func customSetup() {
        setTitle(titleText)
    }
    
    func setTitle(title:String) {
        titleLabel.text = title
    }
    
}
