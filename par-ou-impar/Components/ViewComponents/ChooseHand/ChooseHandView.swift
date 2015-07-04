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
    
}

class ChooseHandView: BaseComponentsView {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    var chooseHandViewDelegate:ChooseHandViewDelegate?
    
    override func customSetup() {
        var nib = UINib(nibName: "HandCountCollectionViewCell", bundle: NSBundle(forClass: self.dynamicType))
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "HandCountCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
    }
    
}

//MARK: UICollectionViewDataSource
extension ChooseHandView:UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:HandCountCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("HandCountCell", forIndexPath: indexPath) as! HandCountCollectionViewCell
        
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
        let height = Float(collectionView.frame.size.height)
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