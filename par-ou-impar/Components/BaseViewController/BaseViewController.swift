//
//  BaseViewController.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/19/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit

protocol BaseProviderCallback {
    
    func prepareToRespose()
    
    func onConnectionFailToRequest();
    
    func onFailRequest(message:String);
}

class BaseViewController: UIViewController {

    var noConnectionPlaceholder:Placeholder?
    
    init(){
        super.init(nibName:NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last! ,bundle:nil);
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.None;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = ColorProvider.getAppColor()
    }
    
    func alert(message:String) {
        let alertController = UIAlertController(title: "Title", message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: { (action) in
            
        } ))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

//MARK: BaseProviderCallback
extension BaseViewController: BaseProviderCallback {
    
    func onConnectionFailToRequest() {
        if(noConnectionPlaceholder == nil){
            noConnectionPlaceholder = view.addPlaceholder("Oh oh!", content: "Wasn't possible to connect", buttonTitle: "Try again", image: nil)
            noConnectionPlaceholder?.delegate = self
        }
    }
    
    func onFailRequest(message:String) {
        alert(message)
    }
    
    func prepareToRespose() {
        view.removePlaceholder(&noConnectionPlaceholder)
    }
    
}

//MARK: PlaceholderActionDelegate
extension BaseViewController: PlaceholderActionDelegate {

    func didClickPlaceholderAction(placeholder:Placeholder) {
        
    }
    
}

//MARK: BaseTableViewManagerDelegate
extension BaseViewController: BaseTableViewManagerDelegate {
    
    func didSelectObject(object: AnyObject) {
        println(object)
    }
    
}
