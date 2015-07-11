//
//  ChooseColorView.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/7/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

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
        collectionViewManager?.updateWithData(ColorProvider.getColors())
    }

}

extension ChooseColorView: BaseTableViewManagerDelegate {
    
    func didSelectObject(object: AnyObject) {
        if widthConstraint!.constant != 190 {
            widthConstraint!.constant = 190
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
