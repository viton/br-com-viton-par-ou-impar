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

class BaseViewController: UIViewController, BaseProviderCallback, PlaceholderActionDelegate {

    var noConnectionPlaceholder:Placeholder?
    
    init(){
        super.init(nibName:NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last! ,bundle:nil);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func alert(message:String) {
        let alertController = UIAlertController(title: "Title", message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: { (action) in
            
        } ))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

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
    
    func didClickPlaceholderAction(placeholder:Placeholder) {
        
    }
    
}
