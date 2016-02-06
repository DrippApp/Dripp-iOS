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
    
    enum ShortcutIdentifier: String {
        case First
        
        // MARK: Initializers
        
        init?(fullType: String) {
            guard let last = fullType.componentsSeparatedByString(".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        // MARK: Properties
        
        var type: String {
            return NSBundle.mainBundle().bundleIdentifier! + ".\(self.rawValue)"
        }
    }


    var window: UIWindow?
    
    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = UIViewController()
        
        switch (shortCutType) {
        case ShortcutIdentifier.First.type:
            // Handle shortcut 1
            vc = storyboard.instantiateViewControllerWithIdentifier("startShower") as! ShowerViewController
            handled = true
            break
        default:
            break
        }
        
        // Display the selected view controller
        window!.rootViewController?.presentViewController(vc, animated: true, completion: nil)
        
        return handled
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        
        completionHandler(handledShortCutItem)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        guard let shortcut = launchedShortcutItem else { return }
        
        handleShortCutItem(shortcut)
        
        launchedShortcutItem = nil
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let tabBarController = self.window!.rootViewController as! UITabBarController
        let tabBar = tabBarController.tabBar as UITabBar
        let inactiveColor = UIColor(hexString: "#91c8fb")
        
        for tabBarItem in tabBar.items!
        {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
            if let image = tabBarItem.image {
                tabBarItem.image = image.imageWithColor(inactiveColor).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        
        // Add background color to middle tabBarItem
        let bgColor = UIColor(hexString: "#3983c8")
        
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let bgView = UIView(frame: CGRectMake((screenWidth/2) - (itemWidth/2), 0, itemWidth, tabBar.frame.height))
        bgView.backgroundColor = bgColor
        tabBar.insertSubview(bgView, atIndex: 0)
        
        let bgView2 = UIView(frame: CGRectMake((screenWidth/2) - (itemWidth/2), (screenHeight-57), itemWidth, tabBar.frame.height/3))
        bgView2.backgroundColor = bgColor
        bgView2.layer.cornerRadius = bgView2.frame.height/2
        bgView2.layer.masksToBounds = false
        bgView2.clipsToBounds = true
        self.window!.rootViewController!.view.insertSubview(bgView2, aboveSubview: bgView)
       
        UINavigationBar.appearance().barTintColor = UIColor.blueHeader
        UIToolbar.appearance().barTintColor = UIColor.blueHeader
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIToolbar.appearance().tintColor = UIColor.blueHeader
        UITabBar.appearance().barTintColor = UIColor.blueHeader
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue3], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forState: .Selected)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
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

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
}