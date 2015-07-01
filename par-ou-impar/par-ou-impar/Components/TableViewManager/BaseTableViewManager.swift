//
//  BaseTableViewManager.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/23/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit

public class BaseTableViewManager: NSObject, UITableViewDataSource {
   
    private var tableView:UITableView?
    private var data:Array<AnyObject>?
    private var registeredNibs:Dictionary<String, String>?
    
    init(tableView:UITableView){
        self.data = []
        self.tableView = tableView
        self.registeredNibs = Dictionary<String, String>()
        super.init()
        self.setupTableView()
    }
    
    private func setupTableView(){
        self.tableView!.dataSource = self
        self.tableView!.tableFooterView = UIView(frame: CGRectZero)
        self.tableView!.backgroundColor = UIColor.clearColor();
    }
    
    private func registerCellNibs(){
        var cellClasses = self.cellClasses();
        for cellClass in cellClasses{
            var cellClassName = getClassName(cellClass)
            var cellClassIdentifier = cellIdentifierForClass(cellClassName)
            if !isNibRegisteredForIdentifier(cellClassIdentifier) {
                registeredNibs!.updateValue(cellClassIdentifier, forKey: cellClassName)
                var cellNib = UINib(nibName: cellClassName, bundle: nil)
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
        self.tableView?.reloadData()
    }
    
    /// This function returns an *Array <AnyClass>* of cells classes that will be used in this *UITableView*
    ///
    /// :returns: *Array <AnyClass>* of cells classes.
    func cellClasses() -> Array<AnyClass> {
        return [TesteTableViewCell.classForCoder()]
    }
    
    /// This function returns a *AnyClass* from the list of cells in this *UITableView* provided by method cellClasses()
    ///
    /// :returns: *AnyClass* of a cell classe. Default return is the first object in array provided by cellClasses().
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
        cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForClass(getClassName(cellClassForItem(item)))) as! UITableViewCell
        
        
        setData(item, toCell: cell)
        
        return cell
    }
    
}
