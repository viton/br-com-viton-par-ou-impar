//
//  Placeholder.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/25/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit

protocol PlaceholderActionDelegate{
    
    func didClickPlaceholderAction(placeholder:Placeholder);
    
}

@IBDesignable class Placeholder: BaseComponentsView {

    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageViewWidhtConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet internal var delegate:AnyObject?;
    
    @IBInspectable var titleText: String = "Placeholder title" {
        didSet {
            setTitle(Messages.message(titleText))
        }
    }
    
    @IBInspectable var contentText: String = "content" {
        didSet {
            setContent(Messages.message(contentText))
        }
    }
    
    @IBInspectable var imageName: UIImage? {
        didSet {
            setImage(imageName)
        }
    }
    
    @IBInspectable var actionTitle: String = "Action" {
        didSet {
            setButtonText(Messages.message(actionTitle))
        }
    }
    
    override func customSetup() {
        setTitle(titleText)
        setContent(contentText)
        setImage(imageName)
        setButtonText(actionTitle)
        backgroundColor = ColorProvider.getAppColor()
    }

    func setTitle(title:String) {
        titleLabel.text = title
    }
    
    func setContent(content:String) {
        contentLabel.text = content
    }
    
    func setImage(image:UIImage?) {
        if(image != nil){
            imageView.image = image;
            imageViewWidhtConstraint.constant = image!.size.width
            imageViewHeightConstraint.constant = image!.size.height
        }
    }
    
    func setButtonText(title:String) {
        button.setTitle(title, forState: UIControlState.Normal)
    }
    
    @IBAction func buttonClick(sender: AnyObject) {
        hidden = true
        if(delegate != nil){
            if let placeholderDelegate = delegate! as? PlaceholderActionDelegate {
                placeholderDelegate.didClickPlaceholderAction(self)
            }
        }
    }
    
}
