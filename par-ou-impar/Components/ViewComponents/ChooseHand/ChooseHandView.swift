//
//  ChooseHandView.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

protocol ChooseHandViewDelegate {
    
    func didSelectHandCount(count:Int)
    
    func didSelectHand(hand:FightHand)
    
}

class ChooseHandView: BaseComponentsView {
    
    @IBOutlet weak var chooseHandTitleLabel: UILabel!
    @IBOutlet weak var optionValueLabel: UILabel!
    @IBOutlet weak var optionTitleLabel: UILabel!
    @IBOutlet weak var handCollectionView: UICollectionView!
    @IBOutlet private weak var collectionView: UICollectionView!
    var chooseHandViewDelegate:ChooseHandViewDelegate?
    var handCollectionManager:CollectionViewManager?
    
    override func customSetup() {
        chooseHandTitleLabel.text = Messages.message("game.choose.hand.title")
        let nib = UINib(nibName: "HandCountCollectionViewCell", bundle: NSBundle(forClass: self.dynamicType))
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "HandCountCell")
        optionTitleLabel.text = Messages.message("option.title")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        handCollectionManager = HandCollectionViewManager(collectionView: handCollectionView, delegate:self)
        handCollectionManager?.updateWithData(FightHandProvider.getHands())
    }
    
}

extension ChooseHandView: BaseTableViewManagerDelegate {
    
    func didSelectObject(object: AnyObject) {
        if let hand = object as? FightHand {
            chooseHandViewDelegate?.didSelectHand(hand)
        }
    }
    
}

//MARK: UICollectionViewDataSource
extension ChooseHandView:UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:HandCountCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("HandCountCell", forIndexPath: indexPath) as! HandCountCollectionViewCell
        
        cell.countLabel.text = String(indexPath.item+1)
        
        return cell
    }
    
}

extension ChooseHandView:UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        chooseHandViewDelegate?.didSelectHandCount(indexPath.item+1)
    }
    
}

extension ChooseHandView:UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let columns = self.collectionView(collectionView, numberOfItemsInSection: 0)
        let width = Float(collectionView.frame.size.width - 1)/Float(columns)
        let height = Float(collectionView.frame.size.height - 1)
        return CGSize(width: width.int, height: height.int)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.1
    }
}

extension Float {
    var cg: CGFloat { return CGFloat(self) }
    var int: Int { return Int(self) }
}