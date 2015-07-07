//
//  CollectionViewManager.swift
//  SwiftStudies
//
//  Created by Taqtile on 7/6/15.
//  Copyright (c) 2015 viton. All rights reserved.
//

import UIKit

class CollectionViewManager: NSObject {
   
    private var collectionView:UICollectionView?
    private var data:Array<AnyObject>?
    var collectionViewManagerDelegate:BaseTableViewManagerDelegate
    private var registeredNibs:Dictionary<String, String>?
    
    init(collectionView:UICollectionView, delegate:BaseTableViewManagerDelegate){
        self.data = []
        self.collectionView = collectionView
        collectionViewManagerDelegate = delegate
        self.registeredNibs = Dictionary<String, String>()
        super.init()
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.backgroundColor = UIColor.clearColor();
    }
    
    private func registerCellNibs(){
        var cellClasses = self.cellClasses();
        for cellClass in cellClasses{
            var cellClassName = getClassName(cellClass)
            var cellClassIdentifier = cellIdentifierForClass(cellClassName)
            if !isNibRegisteredForIdentifier(cellClassIdentifier) {
                registeredNibs!.updateValue(cellClassIdentifier, forKey: cellClassName)
                var cellNib = UINib(nibName: cellClassName, bundle: NSBundle(forClass: self.dynamicType))
                collectionView!.registerNib(cellNib, forCellWithReuseIdentifier: cellClassIdentifier)
            }
            
        }
    }
    
    private func cellIdentifierForClass(name:String) -> String {
        return String(format: "IDENTIFIER_%@", name);
    }
    
    private func getClassName(classType:AnyClass) -> String {
        return NSStringFromClass(classType).componentsSeparatedByString(".").last!
    }
    
    private func isNibRegisteredForIdentifier(identifier:String) -> Bool {
        var keys:Array<String>
        keys = self.registeredNibs!.keys.array
        for key in keys {
            if (key == identifier) {
                return true
            }
        }
        return false;
    }
    
    //MARK: public methods
    func updateWithData(data:Array<AnyObject>){
        self.data = data
        self.registerCellNibs()
        self.collectionView?.reloadData()
    }
    
    /// This function returns an *Array <AnyClass>* of cells classes that will be used in this *UICollectionView*
    ///
    /// :returns: *Array <AnyClass>* of cells classes.
    func cellClasses() -> Array<AnyClass> {
        return [BaseCollectionViewCell.classForCoder()]
    }
    
    /// This function returns a *AnyClass* from the list of cells in this *UICollectionView* provided by method cellClasses()
    ///
    /// :returns: *AnyClass* of a cell classe. Default return is the first object in array provided by cellClasses().
    func cellClassForItem(item:AnyObject) -> AnyClass {
        return cellClasses().first!;
    }
    
    func objectForIndexPath(indexPath:NSIndexPath) -> AnyObject {
        return data![indexPath.item]
    }
    
    func setData(item:AnyObject, toCell cell:UICollectionViewCell) {
        if let baseCell = cell as? BaseCollectionViewCell {
            baseCell.testeLabel.text = item.description
        }
    }
    
}

extension CollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data!.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var object: AnyObject = objectForIndexPath(indexPath)
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifierForClass(getClassName(cellClassForItem(object))), forIndexPath: indexPath) as! UICollectionViewCell
        setData(object, toCell: cell)
        
        return cell
    }
    
}

extension CollectionViewManager: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionViewManagerDelegate.didSelectObject(data![indexPath.item])
    }
}

extension CollectionViewManager: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.1
    }
    
}
