//
//  ToolbarManager.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/30/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

class ToolBarManager: NSObject {
    
    /// Sets the toolbars to a purple background with
    /// white text and tints.
    class func setMainToolbars() {
        let barTintColor = UIColor(red: 0.906, green: 0.243, blue: 0.478, alpha: 1.0)
        let tintColor = UIColor(white: 0.98, alpha: 1.0)
        self.setToolBarColors(tintColor: tintColor, barTintColor: barTintColor,
            textColor: tintColor, lightStatus: true, opaque: true)
    }
    
    /// Sets the toolbars to a purple background with
    /// white text and tints.
    class func setAltToolbars() {
        let barTintColor = UIColor(white: 0.98, alpha: 0)
        let tintColor = UIColor(red: 0.906, green: 0.243, blue: 0.478, alpha: 1.0)
        self.setToolBarColors(tintColor: tintColor, barTintColor: barTintColor,
            textColor: tintColor, lightStatus: false, opaque: false)
    }
    
    /// Sets the system toolbar colors to what your provide.
    ///
    class func setToolBarColors(tintColor tintColor: UIColor, barTintColor: UIColor, textColor: UIColor, lightStatus: Bool, opaque: Bool) {
        var navBarTitleAttributes = [String : AnyObject]()
        navBarTitleAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor()
        
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().translucent = !opaque;
        
        UINavigationBar.appearance().titleTextAttributes = navBarTitleAttributes
        
        UITabBar.appearance().tintColor = tintColor
        UITabBar.appearance().opaque = opaque;
        
        var tabBarSelectedTitleAttributes = [String : AnyObject]()
        tabBarSelectedTitleAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor()
        
        UITabBarItem.appearance().setTitleTextAttributes(tabBarSelectedTitleAttributes, forState: .Selected)
        
        var tabBarUnselectedTitleAttributes = [String : AnyObject]()
        tabBarUnselectedTitleAttributes[NSForegroundColorAttributeName] = UIColor(white: 1.0, alpha: 0.5)
        
        UITabBarItem.appearance().setTitleTextAttributes(tabBarUnselectedTitleAttributes, forState: .Normal)
        UIApplication.sharedApplication().statusBarStyle = lightStatus ? .LightContent : .Default
    }
}