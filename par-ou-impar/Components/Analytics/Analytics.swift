//
//  Analytics.swift
//  par-ou-impar
//
//  Created by Taqtile on 9/24/15.
//  Copyright © 2015 Viton. All rights reserved.
//

import UIKit
import Parse

let ANALYTICS_OPENSCREEN_KEY            = "open_screen"

let ANALYTICS_SCREEN_HOME               = "home"
let ANALYTICS_SCREEN_NEW_GAME           = "new_game"
let ANALYTICS_SCREEN_REPLY_GAME         = "reply_game"
let ANALYTICS_SCREEN_GAME               = "game"
let ANALYTICS_SCREEN_RESULT_SUCCESS     = "result_win"
let ANALYTICS_SCREEN_RESULT_ERROR       = "result_error"
let ANALYTICS_SCREEN_SEARCH_FRIENDS     = "search_friend"
let ANALYTICS_SCREEN_LOGIN              = "login"

class Analytics: NSObject {

    class func trackOpenScreen(screen:String!) {
        PFAnalytics.trackEvent(ANALYTICS_OPENSCREEN_KEY, DISPATCH_MEMORYPRESSURE_NORMAL)
    }
    
}
