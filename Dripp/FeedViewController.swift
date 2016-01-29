//
//  FeedViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController {
    
    let notificationButton = UIButton(type: .Custom)
    let showerImage = UIImage(named:"test")
    let showerWaterImage = UIImage(named:"test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Dripp Feed"
        //set image for button
        notificationButton.setImage(showerImage, forState: .Normal)
        //add function for button
        notificationButton.addTarget(self, action: "notificationsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        notificationButton.frame = CGRectMake(0, 0, 53, 31)
        let barButton = UIBarButtonItem(customView: notificationButton)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    //This method will call when you press button.
    func notificationsButtonPressed() {
        print("shower head pressed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}