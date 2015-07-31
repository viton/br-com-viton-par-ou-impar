//
//  AppSettingsProvider.swift
//  par-ou-impar
//
//  Created by Taqtile on 7/31/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit
import GoogleMobileAds

let NEW_GAME_GOOGLE_ADS_INTERSTITIAL_UNIT_ID = "ca-app-pub-6732487218165467/7775034633"
let MATCH_RESULT_GOOGLE_ADS_INTERSTITIAL_UNIT_ID = "ca-app-pub-6732487218165467/6363960639"
let LOOSE_MATCH_GOOGLE_ADS_INTERSTITIAL_UNIT_ID = " ca-app-pub-6732487218165467/9251767830"
let GOOGLE_ADS_BANNER_UNIT_ID = "ca-app-pub-6732487218165467/7980294632"

let GOOGLE_REQUEST_TEST_DEVICES = [kGADSimulatorID, "f1abdfdf0b24e308ec273def74fd4fd1"]

class AppSettingsProvider: NSObject {
   
    class func getAppStoreURL() ->String! {
        return ""
    }
    
    class func getAppImageURL() ->String! {
        return ""
    }
    
}
