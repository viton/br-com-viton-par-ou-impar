//
//  BaseViewController.swift
//  SwiftPOC
//
//  Created by Taqtile on 6/19/15.
//  Copyright (c) 2015 ProtocolsTesteSwift. All rights reserved.
//

import UIKit

protocol BaseProviderCallback {
    
    func onConnectionFailToRequest(model: DataRequestModel);
    
    func onFailRequest();
}

class BaseViewController: UIViewController, BaseProviderCallback, PlaceholderActionDelegate {

    var noConnectionPlaceholder:Placeholder?
    var pendingRequest:DataRequestModel?
    
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
            if(self.pendingRequest != nil){
                println("Oi ")
                self.pendingRequest!.repeat()
                self.pendingRequest = nil
            }
        } ))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func onConnectionFailToRequest(model: DataRequestModel) {
        if(noConnectionPlaceholder == nil){
            noConnectionPlaceholder = Placeholder(frame: view.frame)
            view.addSubview(noConnectionPlaceholder!)
            view.addAllConstraints(noConnectionPlaceholder!)
            self.pendingRequest = model
            noConnectionPlaceholder?.delegate = self
        }
        noConnectionPlaceholder?.hidden = false
    }
    
    func onFailRequest() {
        alert("Erro")
    }
    
    func didClickPlaceholderAction(placeholder:Placeholder) {
        if pendingRequest != nil {
            pendingRequest?.repeat()
        }
    }
    
}
