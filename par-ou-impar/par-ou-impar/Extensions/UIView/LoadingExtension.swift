//
//  LoadingExtension.swift
//  SwiftStudies
//
//  Created by Taqtile on 6/30/15.
//  Copyright (c) 2015 viton. All rights reserved.
//

import UIKit

extension UIView {

    func startLoading() {
        let loading = Loading(frame:CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        addSubview(loading)
        addAllConstraints(loading)
        loading.start()
    }
    
    func stopLoading() {
        for view in subviews as! [UIView] {
            if(view.isKindOfClass(Loading)){
                let loading = view as! Loading
                loading.stop()
            }
        }
    }
    
    
}