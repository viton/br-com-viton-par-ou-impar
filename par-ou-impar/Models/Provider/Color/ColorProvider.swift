//
//  ColorProvider.swift
//  par-ou-impar
//
//  Created by Vitor Machado oliveira on 04/07/15.
//  Copyright (c) 2015 Viton. All rights reserved.
//

import UIKit

let APP_COLOR_KEY = "APP_COLOR_KEY"

class ColorProvider: NSObject {
    
    class func getAppColor() -> UIColor {
        if let color = NSUserDefaults.standardUserDefaults().colorForKey(APP_COLOR_KEY) {
            return color
        }
        return UIColor.appBlueColor()
    }
    
    class func saveColor(color: UIColor) {
        NSUserDefaults.standardUserDefaults().setColor(color, forKey: APP_COLOR_KEY)
    }
    
    class func getColors() -> [UIColor] {
        var colors = Array<UIColor>()
        var selectedColor = getAppColor()
        colors.append(selectedColor)
        for color in ColorProvider.getAllColors() {
            if(!color.isEqual(selectedColor)) {
                colors.append(color)
            }
        }
        return colors
    }
    
    class func getAllColors() -> [UIColor] {
        return [UIColor.appBlueColor(), UIColor.appRedColor(),
        UIColor.appYellowColor(), UIColor.appGreenColor(), UIColor.appBrownColor()]
    }
    
}

extension NSUserDefaults {
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = dataForKey(key) {
            color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        }
        setObject(colorData, forKey: key)
    }
    
}

extension UIColor {
    
    class func appBlueColor() -> UIColor {
        return UIColor(red: 86.0/255.0, green: 206.0/255.0, blue: 239.0/255.0, alpha: 1)
    }
    
    class func appRedColor() -> UIColor {
        return UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1)
    }
    
    class func appYellowColor() -> UIColor {
        return UIColor(red: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1)
    }
    
    class func appGreenColor() -> UIColor {
        return UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1)
    }
    
    class func appBrownColor() -> UIColor {
        return UIColor.brownColor()
    }
    
}