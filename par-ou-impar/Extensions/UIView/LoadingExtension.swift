//
//  LoadingExtension.swift
//  SwiftStudies
//
//  Created by Taqtile on 6/30/15.
//  Copyright (c) 2015 viton. All rights reserved.
//

import UIKit

extension UIView {

    func startLoadingRandom(message:String) {
        var loading:Loading
        if random()%2 == 1 {
            loading = HandCountLoading(frame:CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        }else {
            loading = OneHandLoading(frame:CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        }
        addSubview(loading)
        addAllConstraints(loading)
        loading.start()
    }
    
    func startLoading() {
        let loading = SimpleLoading(frame:CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        addSubview(loading)
        addAllConstraints(loading)
        loading.start()
    }
    
    func stopLoading() {
        for view in subviews {
            if(view.isKindOfClass(Loading)){
                let loading = view as! Loading
                loading.stop()
            }
        }
    }
    
    
}