//
//  ImageDownloadExtension.swift
//  par-ou-impar
//
//  Created by Vitor Machado oliveira on 05/07/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(url imageURL: String) {
        if let imageUrl = NSURL(string: imageURL) {
            let imageRequest: NSURLRequest = NSURLRequest(URL: imageUrl)
            let queue: NSOperationQueue = NSOperationQueue.mainQueue()
            NSURLConnection.sendAsynchronousRequest(imageRequest, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if data != nil {
                    let image = UIImage(data: data)
                    self.image = image
                    self.circle()
                    self.circle()
                }
            })
        }
    }
    
}