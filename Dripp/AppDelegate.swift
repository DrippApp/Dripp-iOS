//
//  AppDelegate.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/28/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let tabBarController = self.window!.rootViewController as! UITabBarController
        let tabBar = tabBarController.tabBar as UITabBar
        
        for tabBarItem in tabBar.items!
        {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        
        //let middleTabBar = tabBar.items![2] as UITabBarItem
        //middleTabBar.image =
       // middleTabBar.image = middleTabBar.image?.tabBarImageWithCustomTint(UIColor.redColor())
        
        // Add background color to middle tabBarItem
        let itemIndex = 2
        let bgColor = UIColor.blueHeader
        
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
        let bgView = UIView(frame: CGRectMake((itemWidth * CGFloat(itemIndex)+27.5), 0, itemWidth, tabBar.frame.height))
        bgView.backgroundColor = bgColor
        tabBar.insertSubview(bgView, atIndex: 0)
        
        UINavigationBar.appearance().barTintColor = UIColor.blueHeader
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIToolbar.appearance().tintColor = UIColor.blueHeader
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        ToolBarManager.setMainToolbars()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

