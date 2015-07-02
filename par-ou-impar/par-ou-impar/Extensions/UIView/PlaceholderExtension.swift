//
//  PlaceholderExtension.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/2/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

extension UIView {

    func addPlaceholder(title:String, content:String, buttonTitle:String, image:UIImage?) -> Placeholder {
        let placeholder = Placeholder(frame:CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        addSubview(placeholder)
        addAllConstraints(placeholder)
        placeholder.setButtonText(buttonTitle)
        placeholder.setTitle(title)
        placeholder.setContent(content)
        placeholder.setImage(image)
        
        return placeholder
    }
    
    func removePlaceholder(inout placeholder:Placeholder? ) {
        if let auxPlaceholder = placeholder {
            auxPlaceholder.removeFromSuperview()
            placeholder = nil
        }
    }
    
}
