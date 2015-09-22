//
//  ChooseColorView.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/7/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

let COMPONENT_MAX_WIDTH:CGFloat = 190.0

protocol ChooseColorViewCallback {

    func didChooseColor(color:UIColor)
    
}

class ChooseColorView: BaseComponentsView {

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewManager:CollectionViewManager?
    var widthConstraint:NSLayoutConstraint?
    var callback:ChooseColorViewCallback?
    
    override func customSetup() {
        collectionViewManager = ColorCollectionViewManager(collectionView: collectionView, delegate: self)
        updateWithLastColors()
    }
    
    func updateWithLastColors() {
        var data = Array<AnyObject>()
        data.append("")
        data += ColorProvider.getColors()
        collectionViewManager?.updateWithData(data)
    }

}

extension ChooseColorView: BaseTableViewManagerDelegate {
    
    func didSelectObject(object: AnyObject) {
        if widthConstraint!.constant != COMPONENT_MAX_WIDTH {
            widthConstraint!.constant = COMPONENT_MAX_WIDTH
            UIView.animateWithDuration(0.5) {
                self.superview!.layoutIfNeeded()
            }
        }else {
            widthConstraint!.constant = 30
            UIView.animateWithDuration(0.5) {
                self.superview!.layoutIfNeeded()
            }
            if let color = object as? UIColor {
                if (callback != nil) {
                    callback?.didChooseColor(color)
                    updateWithLastColors()
                }
            }
        }
    }
    
}
