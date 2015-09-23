//
//  BaseTableViewManager.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/23/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit

protocol BaseTableViewManagerDelegate {
    
    func didSelectObject(object:AnyObject)
    
}

public class BaseTableViewManager: NSObject, UITableViewDataSource {
   
    private var tableView:UITableView?
    var data:Array<AnyObject>?
    var delegate:BaseTableViewManagerDelegate
    private var registeredNibs:Dictionary<String, String>?
    
    init(tableView:UITableView, delegate:BaseTableViewManagerDelegate){
        self.data = []
        self.tableView = tableView
        self.delegate = delegate
        self.registeredNibs = Dictionary<String, String>()
        super.init()
        self.setupTableView()
    }
    
    private func setupTableView(){
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.tableFooterView = UIView(frame: CGRectZero)
        self.tableView!.backgroundColor = UIColor.clearColor();
    }
    
    private func registerCellNibs(){
        let cellClasses = self.cellClasses();
        for cellClass in cellClasses{
            let cellClassName = getClassName(cellClass)
            let cellClassIdentifier = cellIdentifierForClass(cellClassName)
            if !isNibRegisteredForIdentifier(cellClassIdentifier) {
                registeredNibs!.updateValue(cellClassIdentifier, forKey: cellClassName)
                let cellNib = UINib(nibName: cellClassName, bundle: nil)
                tableView!.registerNib(cellNib, forCellReuseIdentifier: cellClassIdentifier)
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
        keys = [String](self.registeredNibs!.keys)
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
        self.tableView?.reloadData()
    }
    
    /// This function returns an *Array <AnyClass>* of cells classes that will be used in this *UITableView*
    ///
    /// - returns: *Array <AnyClass>* of cells classes.
    func cellClasses() -> Array<AnyClass> {
        return [TesteTableViewCell.classForCoder()]
    }
    
    /// This function returns a *AnyClass* from the list of cells in this *UITableView* provided by method cellClasses()
    ///
    /// - returns: *AnyClass* of a cell classe. Default return is the first object in array provided by cellClasses().
    func cellClassForItem(item:AnyObject) -> AnyClass {
        return cellClasses().first!;
    }
    
    func objectForIndexPath(indexPath:NSIndexPath) -> AnyObject {
        return data![indexPath.row]
    }
    
    func setData(item:AnyObject, toCell cell:UITableViewCell) {
        cell.textLabel?.text = item.description;
    }
    
    //MARK: UITableViewDataSource
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.count
    }
    
    public func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        var item:AnyObject
        
        item = objectForIndexPath(indexPath)
        let cellIdentifier = cellIdentifierForClass(getClassName(cellClassForItem(item)))
        cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        
        
        setData(item, toCell: cell)
        
        return cell
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
}

extension BaseTableViewManager:UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object:AnyObject = data![indexPath.row]
        delegate.didSelectObject(object)
    }
    
}
