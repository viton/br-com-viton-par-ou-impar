//
//  NewGameViewController.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/1/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

class NewGameViewController: BaseViewController {

    var chooseFriendViewController:ChooseFriendViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Novo"
        navigationController?.navigationBarHidden = false
    }

    @IBAction func chooseFriendAction(sender: AnyObject) {
        chooseFriendViewController = ChooseFriendViewController()
        presentViewController(chooseFriendViewController!, animated: true, completion: {
            
        })
    }
    
    
}
