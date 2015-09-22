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
    
    class func getColors() -> Array<AnyObject> {
        var colors = Array<UIColor>()
        let selectedColor = getAppColor()
        colors.append(selectedColor)
        for color in ColorProvider.getAllColors() {
            if(!self.colorsAreEqual(color, secondColor: selectedColor)) {
                colors.append(color)
            }
        }
        return colors
    }
    
    class func getAllColors() -> [UIColor] {
        return [UIColor.appBlueColor(), UIColor.appRedColor(),
        UIColor.appYellowColor(), UIColor.appGreenColor(), UIColor.appBrownColor()]
    }
    
    class func colorsAreEqual(color:UIColor, secondColor:UIColor) -> Bool {
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        
        var red2:CGFloat = 0.0
        var green2:CGFloat = 0.0
        var blue2:CGFloat = 0.0
        var alpha2:CGFloat = 0.0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        secondColor.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        if(red.toInt() == red2.toInt() && green.toInt() == green2.toInt() && blue.toInt() == blue2.toInt()) {
            return true
        }
        return false
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

extension CGFloat {
    
    func toInt() -> Int {
        let intValue = self*10000
        
        return Int(intValue)
    }
    
}

extension UIColor {
    
    class func appBlueColor() -> UIColor {
        return UIColor(red: 86.0/255.0, green: 206.0/255.0, blue: 239.0/255.0, alpha: 1)
    }
    
    class func appRedColor() -> UIColor {
        return UIColor(red: 233.0/255.0, green: 106.0/255.0, blue: 133.0/255.0, alpha: 1)
    }
    
    class func appYellowColor() -> UIColor {
        return UIColor(red: 234.0/255.0, green: 159.0/255.0, blue: 58.0/255.0, alpha: 1)
    }
    
    class func appGreenColor() -> UIColor {
        return UIColor(red: 178.0/255.0, green: 215.0/255.0, blue: 19.0/255.0, alpha: 1)
    }
    
    class func appBrownColor() -> UIColor {
        return UIColor(red: 177.0/255.0, green: 178.0/255.0, blue: 209.0/255.0, alpha: 1)
    }
    
}